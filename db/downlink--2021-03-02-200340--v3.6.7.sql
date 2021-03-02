-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for Linux (x86_64)
--
-- Host: mysql-8.0-3307.database.nitro    Database: myfirstmodule
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `volumeId` int NOT NULL,
  `uri` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assets`
--

DROP TABLE IF EXISTS `craft_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `kind` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  KEY `craft_assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `volumeId` int DEFAULT NULL,
  `fileExists` tinyint(1) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT NULL,
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_volumeId_fileId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mode` enum('stretch','fit','crop') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'center-center',
  `height` int unsigned DEFAULT NULL,
  `width` int unsigned DEFAULT NULL,
  `format` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransforms_name_idx` (`name`),
  KEY `craft_assettransforms_handle_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_fk` (`groupId`),
  KEY `craft_categories_parentId_fk` (`parentId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categorygroups_structureId_fk` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_categorygroups_name_idx` (`name`),
  KEY `craft_categorygroups_handle_idx` (`handle`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups_sites`
--

DROP TABLE IF EXISTS `craft_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `template` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_changedattributes`
--

DROP TABLE IF EXISTS `craft_changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `craft_changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `craft_changedattributes_siteId_fk` (`siteId`),
  KEY `craft_changedattributes_userId_fk` (`userId`),
  CONSTRAINT `craft_changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_changedfields`
--

DROP TABLE IF EXISTS `craft_changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `craft_changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `craft_changedfields_siteId_fk` (`siteId`),
  KEY `craft_changedfields_fieldId_fk` (`fieldId`),
  KEY `craft_changedfields_userId_fk` (`userId`),
  CONSTRAINT `craft_changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_linkUrl` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_linkDescription` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_episodeDescription` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_bookASIN` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_teaserCopy` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_title_idx` (`title`),
  KEY `craft_content_siteId_idx` (`siteId`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_craftidtokens`
--

DROP TABLE IF EXISTS `craft_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fingerprint` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `traces` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_drafts`
--

DROP TABLE IF EXISTS `craft_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `craft_drafts_sourceId_fk` (`sourceId`),
  KEY `craft_drafts_creatorId_fk` (`creatorId`),
  KEY `craft_idx_hdywpuivlbfziirysthhvwikehhfkjwcrxqn` (`saved`),
  CONSTRAINT `craft_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  `archived` tinyint unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_elements_draftId_fk` (`draftId`),
  KEY `craft_elements_revisionId_fk` (`revisionId`),
  KEY `craft_elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  CONSTRAINT `craft_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `craft_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements_sites`
--

DROP TABLE IF EXISTS `craft_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `craft_craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_fk` (`authorId`),
  KEY `craft_entries_parentId_fk` (`parentId`),
  CONSTRAINT `craft_craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafterrors`
--

DROP TABLE IF EXISTS `craft_entrydrafterrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafterrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `craft_entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entryId` int NOT NULL,
  `sectionId` int NOT NULL,
  `creatorId` int NOT NULL,
  `siteId` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `notes` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `data` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_sectionId_fk` (`sectionId`),
  KEY `craft_entrydrafts_creatorId_fk` (`creatorId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  CONSTRAINT `craft_craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hasTitleField` tinyint unsigned NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `titleFormat` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrytypes_sectionId_fk` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `craft_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversionerrors`
--

DROP TABLE IF EXISTS `craft_entryversionerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversionerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `versionId` int DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `craft_entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `craft_entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entryId` int NOT NULL,
  `sectionId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `siteId` int NOT NULL,
  `num` smallint unsigned NOT NULL,
  `notes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `data` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_sectionId_fk` (`sectionId`),
  KEY `craft_entryversions_creatorId_fk` (`creatorId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  CONSTRAINT `craft_craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_feedme_feeds`
--

DROP TABLE IF EXISTS `craft_feedme_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_feedme_feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feedUrl` text NOT NULL,
  `feedType` varchar(255) DEFAULT NULL,
  `primaryElement` varchar(255) DEFAULT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementGroup` text,
  `siteId` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `singleton` tinyint(1) NOT NULL DEFAULT '0',
  `duplicateHandle` text,
  `paginationNode` text,
  `fieldMapping` text,
  `fieldUnique` text,
  `passkey` varchar(255) NOT NULL,
  `backup` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldgroups_name_idx` (`name`),
  KEY `craft_idx_qenwonjjrwmvyjrzsmydhezfxfozscrdedkz` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint unsigned NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_fk` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`),
  KEY `craft_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `elements` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(58) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `instructions` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `translationKeyFormat` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_groupId_fk` (`groupId`),
  KEY `craft_fields_handle_context_idx` (`handle`,`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_globalsets_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_globalsets_name_idx` (`name`),
  KEY `craft_globalsets_handle_idx` (`handle`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqlschemas`
--

DROP TABLE IF EXISTS `craft_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqltokens`
--

DROP TABLE IF EXISTS `craft_gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `craft_gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `craft_gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `maintenance` tinyint unsigned NOT NULL DEFAULT '0',
  `configVersion` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int NOT NULL,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `craft_matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixcontent_body`
--

DROP TABLE IF EXISTS `craft_matrixcontent_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixcontent_body` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `field_text_textContent` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_blockquote_quote` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_blockquote_citation` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_image_caption` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `field_image_layout` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_craft_matrixcontent_body_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_craft_matrixcontent_body_siteId_fk` (`siteId`),
  CONSTRAINT `craft_craft_matrixcontent_body_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixcontent_body_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_projectconfig`
--

DROP TABLE IF EXISTS `craft_projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_queue`
--

DROP TABLE IF EXISTS `craft_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `craft_queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_rackspaceaccess`
--

DROP TABLE IF EXISTS `craft_rackspaceaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_rackspaceaccess` (
  `id` int NOT NULL AUTO_INCREMENT,
  `connectionKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `storageUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cdnUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_rackspaceaccess_connectionKey_unq_idx` (`connectionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_fk` (`sourceId`),
  KEY `craft_relations_targetId_fk` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_resourcepaths`
--

DROP TABLE IF EXISTS `craft_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_revisions`
--

DROP TABLE IF EXISTS `craft_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `craft_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('single','channel','structure') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint unsigned NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'all',
  `previewTargets` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sections_structureId_fk` (`structureId`),
  KEY `craft_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sections_name_idx` (`name`),
  KEY `craft_sections_handle_idx` (`handle`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections_sites`
--

DROP TABLE IF EXISTS `craft_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `enabledByDefault` tinyint unsigned NOT NULL DEFAULT '1',
  `uriFormat` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `template` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sequences`
--

DROP TABLE IF EXISTS `craft_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_fk` (`userId`),
  CONSTRAINT `craft_craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sitegroups`
--

DROP TABLE IF EXISTS `craft_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sites`
--

DROP TABLE IF EXISTS `craft_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint unsigned DEFAULT NULL,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  KEY `craft_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sites_handle_idx` (`handle`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_systemmessages`
--

DROP TABLE IF EXISTS `craft_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `subject` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `craft_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_taggroups_name_idx` (`name`),
  KEY `craft_taggroups_handle_idx` (`handle`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_fk` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int NOT NULL,
  `elementId` int NOT NULL,
  KEY `craft_templatecacheelements_cacheId_fk` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecachequeries`
--

DROP TABLE IF EXISTS `craft_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachequeries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `query` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `siteId` int NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `route` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_usergroups_handle_idx` (`handle`),
  KEY `craft_usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_fk` (`userId`),
  CONSTRAINT `craft_craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_fk` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_fk` (`userId`),
  CONSTRAINT `craft_craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpreferences`
--

DROP TABLE IF EXISTS `craft_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpreferences` (
  `userId` int NOT NULL,
  `preferences` text,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `craft_craft_userpreferences_userId_unq_idx` (`userId`),
  CONSTRAINT `craft_craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `photoId` int DEFAULT NULL,
  `firstName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint unsigned NOT NULL DEFAULT '0',
  `locked` tinyint unsigned NOT NULL DEFAULT '0',
  `suspended` tinyint unsigned NOT NULL DEFAULT '0',
  `pending` tinyint unsigned NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordResetRequired` tinyint unsigned NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_photoId_fk` (`photoId`),
  KEY `craft_users_email_idx` (`email`),
  KEY `craft_users_username_idx` (`username`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumefolders`
--

DROP TABLE IF EXISTS `craft_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_craft_volumefolders_parentId_fk` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumes`
--

DROP TABLE IF EXISTS `craft_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `titleTranslationMethod` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text COLLATE utf8_unicode_ci,
  `settings` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_volumes_name_idx` (`name`),
  KEY `craft_volumes_handle_idx` (`handle`),
  CONSTRAINT `craft_craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_fk` (`userId`),
  CONSTRAINT `craft_craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'myfirstmodule'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-02 20:03:40
-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for Linux (x86_64)
--
-- Host: mysql-8.0-3307.database.nitro    Database: myfirstmodule
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `craft_assets`
--

LOCK TABLES `craft_assets` WRITE;
/*!40000 ALTER TABLE `craft_assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_assets` VALUES (4,1,1,NULL,'cms-statamic.mp3','audio',NULL,NULL,14237437,NULL,NULL,NULL,'2021-01-18 20:10:47','2016-06-25 02:01:29','2021-01-18 20:42:54','0cf7f549-c4b5-4958-b59e-0073b3aadf65'),(8,2,2,NULL,'pioneer-10-nasa-flickr-commons.jpg','image',2048,1295,624868,NULL,0,1,'2016-06-25 02:16:00','2016-06-25 02:16:00','2016-06-25 02:16:00','221c62a9-22f9-4fb0-86f8-9fdd3f4a9c56'),(14,2,2,NULL,'pioneer-missions.jpg','image',1452,992,210668,NULL,0,1,'2016-06-25 02:22:30','2016-06-25 02:22:30','2016-06-25 02:22:30','3f7bfa2f-c12b-4e49-bbc2-43c41d381dc0'),(198,2,2,NULL,'cms-statamic.mp3','audio',NULL,NULL,14237437,NULL,0,1,'2021-01-18 20:10:47','2021-01-18 20:42:54','2021-01-18 20:42:54','4317fe59-b04b-41c3-95eb-357a94f4c263'),(199,2,2,NULL,'background-stars.gif','image',1200,800,81290,NULL,NULL,NULL,'2021-01-18 20:10:47','2021-01-18 20:44:07','2021-01-18 20:44:07','44973fe7-046f-49ae-bf22-731d3bc2472c'),(200,2,2,NULL,'pioneer-10-nasa-flickr-commons.jpg','image',2048,1295,624868,NULL,NULL,NULL,'2021-01-18 20:10:47','2021-01-18 20:44:07','2021-01-18 20:44:07','b509cb41-aeb2-4b04-aaa8-eac0aa5b5453'),(201,2,2,NULL,'pioneer-missions.jpg','image',1452,992,210668,NULL,NULL,NULL,'2021-01-18 20:10:47','2021-01-18 20:44:07','2021-01-18 20:44:07','f6f147fa-8723-47e9-a674-c8b1c876ea03');
/*!40000 ALTER TABLE `craft_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups_sites`
--

LOCK TABLES `craft_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_changedattributes`
--

LOCK TABLES `craft_changedattributes` WRITE;
/*!40000 ALTER TABLE `craft_changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_changedattributes` VALUES (96,1,'title','2021-01-18 20:27:23',0,1),(97,1,'slug','2021-01-18 20:27:23',0,1),(97,1,'title','2021-01-18 20:27:23',0,1),(195,1,'slug','2021-01-18 20:27:24',0,1),(195,1,'title','2021-01-18 20:27:24',0,1),(196,1,'slug','2021-01-18 20:27:24',0,1),(196,1,'title','2021-01-18 20:27:24',0,1);
/*!40000 ALTER TABLE `craft_changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_changedfields`
--

LOCK TABLES `craft_changedfields` WRITE;
/*!40000 ALTER TABLE `craft_changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_changedfields` VALUES (9,1,1,'2021-01-18 20:51:49',0,1),(9,1,16,'2021-01-18 20:51:49',0,1),(27,1,1,'2021-01-18 20:27:23',0,1),(27,1,2,'2021-01-18 20:27:23',0,1),(27,1,15,'2021-01-18 20:27:23',0,1),(27,1,16,'2021-01-18 20:27:23',0,1),(35,1,1,'2021-01-18 20:27:23',0,1),(35,1,2,'2021-01-18 20:27:23',0,1),(35,1,15,'2021-01-18 20:27:23',0,1),(35,1,16,'2021-01-18 20:27:23',0,1),(50,1,1,'2021-01-18 20:27:23',0,1),(50,1,2,'2021-01-18 20:27:23',0,1),(50,1,15,'2021-01-18 20:27:23',0,1),(50,1,16,'2021-01-18 20:27:23',0,1),(65,1,1,'2021-01-18 20:27:23',0,1),(65,1,2,'2021-01-18 20:27:23',0,1),(65,1,15,'2021-01-18 20:27:23',0,1),(65,1,16,'2021-01-18 20:27:23',0,1),(80,1,1,'2021-01-18 20:27:23',0,1),(80,1,2,'2021-01-18 20:27:23',0,1),(80,1,15,'2021-01-18 20:27:23',0,1),(95,1,11,'2021-01-18 20:27:23',0,1),(95,1,13,'2021-01-18 20:27:23',0,1),(96,1,11,'2021-01-18 20:27:23',0,1),(96,1,13,'2021-01-18 20:27:23',0,1),(97,1,11,'2021-01-18 20:27:23',0,1),(97,1,13,'2021-01-18 20:27:23',0,1),(98,1,1,'2021-01-18 20:27:23',0,1),(98,1,2,'2021-01-18 20:27:23',0,1),(113,1,1,'2021-01-18 20:27:24',0,1),(113,1,14,'2021-01-18 20:27:24',0,1),(121,1,1,'2021-01-18 20:27:24',0,1),(121,1,2,'2021-01-18 20:27:24',0,1),(136,1,1,'2021-01-18 20:27:24',0,1),(136,1,2,'2021-01-18 20:27:24',0,1),(150,1,1,'2021-01-18 20:27:24',0,1),(150,1,2,'2021-01-18 20:27:24',0,1),(163,1,1,'2021-01-18 20:27:24',0,1),(163,1,2,'2021-01-18 20:27:24',0,1),(175,1,1,'2021-01-18 20:27:24',0,1),(175,1,2,'2021-01-18 20:27:24',0,1),(185,1,1,'2021-01-18 20:27:24',0,1),(185,1,2,'2021-01-18 20:27:24',0,1),(193,1,9,'2021-01-18 20:27:24',0,1),(193,1,10,'2021-01-18 20:27:24',0,1),(194,1,9,'2021-01-18 20:27:24',0,1),(194,1,10,'2021-01-18 20:27:24',0,1),(195,1,11,'2021-01-18 20:27:24',0,1),(195,1,13,'2021-01-18 20:27:24',0,1),(196,1,11,'2021-01-18 20:27:24',0,1),(196,1,13,'2021-01-18 20:27:24',0,1);
/*!40000 ALTER TABLE `craft_changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_content` VALUES (1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'2016-06-24 17:18:51','2021-01-18 20:52:39','92d6d27b-d5e3-42c4-b505-de3612288193'),(2,2,1,'Welcome to Downlinkpodcast.dev!',NULL,NULL,NULL,NULL,NULL,'2016-06-24 17:18:55','2021-01-18 20:25:28','8c86a2d6-768c-459d-8146-c2c10262888c'),(4,4,1,'Cms Statamic',NULL,NULL,NULL,NULL,NULL,'2016-06-25 02:01:29','2021-01-18 20:44:07','158fb157-21fd-45f5-a81d-33de83c53433'),(5,5,1,'Episode 26: Looking Back at Pathfinder',NULL,NULL,'<p>In this episode we recall our work together on the Mars Pathfinder mission and the Sojourner rover. </p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br /></p>',NULL,NULL,'2016-06-25 02:02:02','2021-01-18 20:58:19','5b63fa1a-575f-4fa8-871e-045d77d1c4e0'),(6,6,1,'A Link to a Great Article','http://google.com','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',NULL,NULL,NULL,'2016-06-25 02:03:21','2016-06-26 01:58:57','642c56d4-69c0-4bee-9464-978a4adf2a4d'),(7,7,1,'Another Link to an Interesting Article','http://mijingo.com','<blockquote>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.<br /></blockquote><p> Ut enim!</p>',NULL,NULL,NULL,'2016-06-25 02:04:40','2016-06-26 01:58:58','5e618bf5-3140-4503-807a-23d6c8bd3159'),(8,8,1,'Pioneer 10 Nasa Flickr Commons',NULL,NULL,NULL,NULL,NULL,'2016-06-25 02:16:00','2016-06-25 02:16:00','4e9d4c2b-f2b4-4361-ba6a-fecfd10f07e6'),(9,9,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>','2016-06-25 02:16:44','2021-01-18 20:51:49','7e536369-5004-4156-8382-a110b619991f'),(10,14,1,'Pioneer Missions',NULL,NULL,NULL,NULL,NULL,'2016-06-25 02:22:30','2016-06-25 02:22:30','266d3ffc-6030-4eb1-8810-a063fd0a603e'),(11,18,1,'This is a Review',NULL,NULL,NULL,'B011LSGMT2',NULL,'2016-06-27 19:21:57','2016-06-28 22:51:08','6c5add7a-b72e-4d10-8135-33331a8c204a'),(12,22,1,'pioneer10',NULL,NULL,NULL,NULL,NULL,'2016-06-28 22:58:18','2016-06-28 22:58:18','1ca623a2-35bd-4471-a365-47f95e693bb9'),(13,23,1,'retrospective',NULL,NULL,NULL,NULL,NULL,'2016-06-28 22:58:22','2016-06-28 22:58:22','dbb3bf7e-a57a-40d1-ad37-c979de3927be'),(14,24,1,'Welcome to Downlinkpodcast.dev!',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:25:27','2021-01-18 20:25:27','f3c8102d-d439-40aa-8041-33e338fdb811'),(15,25,1,'Welcome to Downlinkpodcast.dev!',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:25:27','2021-01-18 20:25:27','14eb5c64-cf92-470c-9722-ccc524b43822'),(16,26,1,'Welcome to Downlinkpodcast.dev!',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:25:28','2021-01-18 20:25:28','f778191e-bca9-4a17-8560-03f46fb8869c'),(17,27,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','767b7048-b9f1-41eb-a8f4-83be741c8b74'),(18,35,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','d9378fb6-efb2-4b8a-aa7b-02d7e226a9ad'),(19,50,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','0ab87242-2fbf-4eae-b168-b52988beb2e1'),(20,65,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','d13445ed-04f7-4a6b-8eb8-b695a93bd0d6'),(21,80,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','4d1ea9f3-1384-4ac5-b4ec-a7428ad25efe'),(22,95,1,'Episode 26: Looking Back at Pathfinder',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','54f927c7-5b09-4c05-babb-7ad303cc1fe5'),(23,96,1,'Episode 26: Looking Back at the Pathfinder',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','4f88d9fc-77d7-4571-8c5f-0eb858ebc07e'),(24,97,1,'Episode 26: Looking Back at the Pathfinder',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','6be023a6-cd88-42a0-85ed-bbfb6128ca08'),(25,98,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','cbc17709-bf9f-4658-a85b-b0b55bbfbab4'),(26,113,1,'This is a Review',NULL,NULL,NULL,'B011LSGMT2',NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','88a84f84-95b9-4b23-a292-7f39c4f11e90'),(27,117,1,'This is a Review',NULL,NULL,NULL,'B011LSGMT2',NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','17843305-d08d-415f-9ce2-d6d9ac74cf7e'),(28,121,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','35128926-90af-4f6e-a101-e73e82c3784b'),(29,136,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','ff134416-8204-4bb6-9553-57a2e97e15f3'),(30,150,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','610405e5-68d6-4670-91b9-9e1ce88a400b'),(31,163,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','11a1dedd-988d-4a7f-b8ae-111a1e10114f'),(32,175,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','752eb40e-4c7b-4447-9665-116d0711c39b'),(33,185,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','19b9281c-2995-461d-a273-2c0ed65ad2a3'),(34,193,1,'Another Link to an Interesting Article','http://mijingo.com',NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3d5a210c-1d3b-4daf-95a8-0b7ff8fcffd0'),(35,194,1,'A Link to a Great Article','http://google.com',NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3e5da33a-081a-4d47-a2b3-fff5165c98ad'),(36,195,1,'Justin Krause of Asana',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','0ab3db47-a9c8-45d0-8318-a912b80637b9'),(37,196,1,'Just Krause of Asana',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','243ee2d8-3cdb-4ce9-8af5-5b65c9da8fca'),(38,197,1,'Episode 26: Looking Back at Pathfinder',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','0c42a54b-3eee-422a-be50-6e5fc622cb48'),(39,198,1,'Cms statamic',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:42:54','2021-01-18 20:43:19','24ba044d-3c65-4743-8bb3-9ec856df4924'),(40,199,1,'Background stars',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:44:07','2021-01-18 20:44:07','522213f9-83c9-4768-882f-c65f8f5ac9fd'),(41,200,1,'Pioneer 10 nasa flickr commons',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:44:07','2021-01-18 20:44:07','9a2ced69-506d-4503-9617-a0ee84c5de05'),(42,201,1,'Pioneer missions',NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:44:07','2021-01-18 20:44:07','e490052b-9510-4570-ae44-8baab49b17bc'),(43,202,1,'Back in Time: Pioneer 10',NULL,NULL,NULL,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>','2021-01-18 20:51:49','2021-01-18 20:51:49','05f1ac71-fbbe-4d9c-bbda-45489210be83'),(44,210,1,'Episode 26: Looking Back at Pathfinder',NULL,NULL,'<p>In this episode we recall our work together on the Mars Pathfinder mission and the Sojourner rover. </p>\n\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br /></p>',NULL,NULL,'2021-01-18 20:58:19','2021-01-18 20:58:19','e1fec963-ff86-4bec-bdcc-26049c65289e');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_craftidtokens`
--

LOCK TABLES `craft_craftidtokens` WRITE;
/*!40000 ALTER TABLE `craft_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_drafts`
--

LOCK TABLES `craft_drafts` WRITE;
/*!40000 ALTER TABLE `craft_drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2016-06-24 17:18:51','2021-01-18 20:52:39',NULL,'ad437413-fc38-462f-bd6f-79dd30c0e29c'),(2,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2016-06-24 17:18:55','2021-01-18 20:25:28',NULL,'031330ce-48bc-4a76-896d-38b57818412b'),(4,NULL,NULL,20,'craft\\elements\\Asset',1,0,'2016-06-25 02:01:29','2021-01-18 20:44:07',NULL,'7062eb45-a599-44af-b1cd-2a8d8f7195a7'),(5,NULL,NULL,21,'craft\\elements\\Entry',1,0,'2016-06-25 02:02:02','2021-01-18 20:58:19',NULL,'f71b1591-d29d-439b-ba2b-d0e956372eae'),(6,NULL,NULL,17,'craft\\elements\\Entry',1,0,'2016-06-25 02:03:21','2016-06-26 01:58:57',NULL,'822dfc82-81e0-4046-bc75-25809643395e'),(7,NULL,NULL,17,'craft\\elements\\Entry',1,0,'2016-06-25 02:04:40','2016-06-26 01:58:58',NULL,'b527e198-b6f1-4167-a9e1-a6a44940b31d'),(8,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2016-06-25 02:16:00','2016-06-25 02:16:00','2021-01-18 20:43:17','60566cde-1399-4803-acf1-fccc9987f563'),(9,NULL,NULL,30,'craft\\elements\\Entry',1,0,'2016-06-25 02:16:44','2021-01-18 20:51:49',NULL,'8144c8cd-2ce2-44ac-b246-546edc64e57c'),(10,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2016-06-25 02:16:44','2021-01-18 20:51:49',NULL,'472245ab-bca4-40ed-af48-0dbbe9ac0adb'),(11,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2016-06-25 02:16:44','2016-06-29 03:28:18',NULL,'085d5a56-5003-4cf5-b524-38b160ff68a3'),(12,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2016-06-25 02:16:44','2021-01-18 20:51:49',NULL,'9479dd2c-72a3-47f0-9560-8b1acbd848ed'),(13,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2016-06-25 02:17:08','2016-06-29 03:28:18',NULL,'9d19dff7-118c-4ff8-8db3-7d47aab97aec'),(14,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2016-06-25 02:22:30','2016-06-25 02:22:30','2021-01-18 20:43:17','077a0dac-e2ce-4f50-a7c5-6a3d12f86060'),(15,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2016-06-25 02:22:42','2021-01-18 20:51:49',NULL,'28269551-104d-442e-b376-58ccffb123b5'),(16,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2016-06-26 00:40:56','2016-06-29 03:28:18',NULL,'30c482bc-1622-42a8-aba5-50bc0f79f7c9'),(17,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2016-06-26 00:44:58','2016-06-29 03:28:18',NULL,'7433b8cc-405c-4caf-b5f4-69f01bd9ca4d'),(18,NULL,NULL,28,'craft\\elements\\Entry',1,0,'2016-06-27 19:21:57','2016-06-28 22:51:08',NULL,'8c33677a-9b03-4a05-bbd4-ca32b47716a7'),(19,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2016-06-27 19:21:57','2016-06-28 22:51:09',NULL,'51b5580e-6850-4bc3-8a8b-1c0ec361e3a5'),(20,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2016-06-27 19:21:57','2016-06-28 22:51:09',NULL,'bca06414-946b-4334-bf11-934e1cfb4c76'),(21,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2016-06-27 19:21:57','2016-06-28 22:51:09',NULL,'48846249-67b9-4065-b446-502b0f8abebd'),(22,NULL,NULL,1,'craft\\elements\\Tag',1,0,'2016-06-28 22:58:18','2016-06-28 22:58:18',NULL,'cacb1e36-0c50-4d55-bd07-33f19036dcb1'),(23,NULL,NULL,1,'craft\\elements\\Tag',1,0,'2016-06-28 22:58:22','2016-06-28 22:58:22',NULL,'0663364e-e77b-4c8b-b67a-2a26a7e49fa5'),(24,NULL,1,3,'craft\\elements\\Entry',1,0,'2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'4e6449b9-0b56-4852-8896-98018bd0339c'),(25,NULL,2,3,'craft\\elements\\Entry',1,0,'2021-01-18 20:25:27','2021-01-18 20:25:27',NULL,'bdb0a08c-21d5-42a1-b3dc-1f86127d6f40'),(26,NULL,3,3,'craft\\elements\\Entry',1,0,'2021-01-18 20:25:28','2021-01-18 20:25:28',NULL,'ade6acb9-c8cb-4071-8103-7eca72e18b83'),(27,NULL,4,30,'craft\\elements\\Entry',1,0,'2016-06-29 03:28:18','2021-01-18 20:27:23',NULL,'cdcb9f9d-7f55-427d-b246-adb14597377d'),(28,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'7668d053-2d1b-4194-8ab0-62e495b1639f'),(29,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'283819ab-28f8-4382-91ce-49a8a777e250'),(30,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'2de5fdcc-0ecc-4f3a-9c05-7da7f919dd6b'),(31,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'90203647-b41b-40b3-82cd-420f19a09777'),(32,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'f02f0f3f-13a0-4196-8d8b-abaed3414e87'),(33,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'76319756-982b-4944-9335-722859877f55'),(34,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'dd507be0-fd55-4343-9644-1280b8633c8f'),(35,NULL,5,30,'craft\\elements\\Entry',1,0,'2016-06-29 03:17:29','2021-01-18 20:27:23',NULL,'109498a7-a622-460c-bce1-9aa8303994a9'),(36,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','03e82ab5-680a-4aa3-b79a-8b02e084bde2'),(37,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','e481bafa-d7dd-4d42-8b1a-5f547ec6fe80'),(38,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','de289d08-15e8-4f35-aa2d-b1159e421e3f'),(39,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','d046adba-db9e-456a-9cdc-c68922ab82b5'),(40,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','b0e9ea1f-f08b-4cd0-891a-0651e8f08f97'),(41,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','6fd37016-f1dc-4287-979a-600b23740cf6'),(42,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','97f404bb-c915-4961-aed7-b5e9fafc2dfb'),(43,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'33ecd251-e119-46f9-8e69-cb8752fbd4e9'),(44,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'7faa71a4-dced-4318-9485-7cad80e0a835'),(45,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'c1dfa8ff-173f-4137-842b-a6a0ae28cff5'),(46,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'8f9eca85-e3c7-46b0-a8e0-84e52e9825b2'),(47,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'4b4e860f-83e7-48dd-ba7f-40eb7b75ce08'),(48,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'0849f885-4a0d-4cc4-9407-67c8aa7edc53'),(49,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'e5ba5069-a22e-4fb3-9443-8fffbed69740'),(50,NULL,6,30,'craft\\elements\\Entry',1,0,'2016-06-29 03:16:10','2021-01-18 20:27:23',NULL,'21d1c5d7-8434-4d70-8bfc-6ac198abe6de'),(51,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','8a6f5a29-31c7-4106-acaf-11d7670e2338'),(52,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','b141a66d-0a61-4368-874a-1180663d892f'),(53,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','e44ddc62-268f-410e-953d-ca3c9cb9aeeb'),(54,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','1511842b-4546-44cb-896e-1d795f6b02a6'),(55,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','e61556f6-9e15-487e-82fb-6519d79e87ee'),(56,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','fd4ac3f7-d465-4bdf-9555-d043f7bf31e5'),(57,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','8f9ee649-6abd-4e1b-9c31-f91a0b5abb2e'),(58,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'4a3207ab-ce32-421f-b762-6463309f5a37'),(59,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'e51799dd-224d-4a8c-9b9a-97b2b62589bf'),(60,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'e6ade35d-ee52-4286-a2f6-4f2a223e7eb4'),(61,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'d112709a-35f6-4dd9-91ea-956e3074fc6d'),(62,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'d343e697-6edf-4315-9121-9f02548c5f37'),(63,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'254153c5-9aaa-4810-b2ff-4715238262ab'),(64,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'b0892aad-8909-41ed-b0cc-de68d2a70b1f'),(65,NULL,7,30,'craft\\elements\\Entry',1,0,'2016-06-29 03:15:14','2021-01-18 20:27:23',NULL,'548a88e1-f668-45cd-8d81-9802b716cc17'),(66,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','42b0a260-1936-4885-a936-e1d43c067cf0'),(67,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','bde88253-3afd-4c36-9afc-3c6f5918b56e'),(68,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','54004f5b-fc0f-4c17-b411-4faecce0d008'),(69,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','6ffaebc3-5a88-4a58-acfe-674c8e24eebb'),(70,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','97ec16fd-cd60-4b00-9680-a68d807115ce'),(71,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','2ecda7f5-f999-4105-af1e-e1aa565a7139'),(72,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','529ef2a1-0de7-4a32-b46b-fd470376d0cb'),(73,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'1d9975f0-6fb3-497d-b663-7655ce309773'),(74,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'55714a26-fbbb-4e7f-8d56-af9f7423481c'),(75,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'5d9fd6e9-93d6-41a7-96fc-30d5e1cda29b'),(76,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'31d908f8-f6c7-468e-b19d-d4642a524ba6'),(77,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'cf13418d-6c38-4897-b6b0-3e77d3d5779f'),(78,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'0c53d097-8122-4b1f-a4f9-0b082710ec5d'),(79,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'6f434555-5df6-4a2b-b6b5-b5ca6b252968'),(80,NULL,8,30,'craft\\elements\\Entry',1,0,'2016-06-29 03:05:06','2021-01-18 20:27:23',NULL,'08df33bd-2da5-4c63-b657-a016e2db13ae'),(81,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','5629b5cf-f620-40e1-b56b-8ec8429ae3a5'),(82,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','164e0207-f3a9-4c5d-bbf4-6c8ffdbab9c4'),(83,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','c0404ec2-6c21-4721-8be9-0840e390eb8c'),(84,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','bb38b438-d328-403c-924f-dd2a40d22ac0'),(85,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','0dae131a-bd5c-48fb-a10f-5ff387afb9bb'),(86,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','3cd527e2-e5c3-4d0d-b07c-7d4f8ac7d29b'),(87,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','7e48ec91-960b-489a-b638-050c859833ac'),(88,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'3c0c8bd1-1bc6-41fc-9b03-ef921b7096bd'),(89,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'ecb92ede-95a3-46f5-aa87-f8ce5bc6907d'),(90,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'82fdd412-9176-4e69-b57f-30e13c159b0d'),(91,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'a9aa9bcc-69d4-4425-be1b-8d849dcc2744'),(92,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'3125f3a8-ccd5-4216-bc83-46489bf40d1b'),(93,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'d091aca2-7a93-4c73-8ff5-044ad07dd2e8'),(94,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'250b1a21-cf74-4517-a2fb-4574f4644348'),(95,NULL,9,21,'craft\\elements\\Entry',1,0,'2016-06-28 23:23:33','2021-01-18 20:27:23',NULL,'4c62b81c-32ec-4f95-9bf7-2c945d21648c'),(96,NULL,10,21,'craft\\elements\\Entry',1,0,'2016-06-28 23:23:05','2021-01-18 20:27:23',NULL,'4f9c0853-2e7b-4e0d-8bc9-2696d42040b6'),(97,NULL,11,21,'craft\\elements\\Entry',1,0,'2016-06-28 23:22:58','2021-01-18 20:27:23',NULL,'71110d4b-dfe1-4e29-9b24-672f8b70cbec'),(98,NULL,12,30,'craft\\elements\\Entry',1,0,'2016-06-28 22:58:26','2021-01-18 20:27:23',NULL,'cb2fb9fe-acb5-4cc4-bc78-e6561b826bc5'),(99,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','8a8c9bf4-c779-47b6-90d6-f8bbd22200a9'),(100,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','a0e037ce-c68b-4b54-854a-957cb397857b'),(101,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','80577677-f849-4bd6-a01c-bb2a144bfb03'),(102,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','212bbf50-2b00-4adc-bedb-8bde7a559c73'),(103,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','6a71b45f-049c-4a9e-b661-b1f38fd4463f'),(104,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','8beb8a20-3dd9-48bc-aa30-b4d01c9b949e'),(105,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','2021-01-18 20:27:23','d62ee207-a6b3-4e88-abf3-aeac776fb03d'),(106,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'d9ca964d-f526-45cd-ba57-d9aef1746d41'),(107,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'1fb6c5b9-e3d7-4647-af36-fb4dc80d1b97'),(108,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'774179b4-ab82-4f14-aff2-d142a9404396'),(109,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'d1afad14-a7fd-487f-b36d-b4f511cbb555'),(110,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'4ef5dcca-38ce-4621-a3a2-3cb1c8c61e0a'),(111,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'791c67af-3e4c-46b2-afae-6c3bfd11adf9'),(112,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'2a61bffe-ac37-447f-946e-21a291809460'),(113,NULL,13,28,'craft\\elements\\Entry',1,0,'2016-06-28 22:51:09','2021-01-18 20:27:23',NULL,'7598fa0b-65c6-4f17-a980-79e3cdbcb9fb'),(114,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23',NULL,'1aa95233-3a69-416e-a26c-05cadba17f4c'),(115,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:24',NULL,'5910a4c5-5a8f-4cf9-a398-1af5cd85eb12'),(116,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:23','2021-01-18 20:27:24',NULL,'277fd41d-22d8-44df-8be4-cad7771b63f3'),(117,NULL,14,28,'craft\\elements\\Entry',1,0,'2016-06-27 19:21:57','2016-06-28 22:51:08',NULL,'fa30ff11-ecc3-4f0b-8498-5c4abf9bd16d'),(118,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23',NULL,'a49933ef-2663-4bc1-81ea-ca6ee27545d9'),(119,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'fb066854-c3d2-4376-965e-6447559afa65'),(120,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'2f7a72c9-e41e-4278-bf7e-63fd2e634187'),(121,NULL,15,30,'craft\\elements\\Entry',1,0,'2016-06-26 00:44:58','2021-01-18 20:27:24',NULL,'983638ff-64c9-41ad-a255-41a1c650c326'),(122,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','a029f381-c540-44a4-803d-6271a4fdf216'),(123,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','83196721-dbd8-441d-8453-9478f7d9ca45'),(124,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','bbc4da41-5853-4bfc-aeb2-25257975b953'),(125,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','49d4bde8-75ab-4e1c-af23-e1a02a409aea'),(126,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','5edfeaa0-6189-4143-a774-d88dec41488e'),(127,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','97bb1d92-1461-44ff-a7f4-5b755889200d'),(128,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:23','2021-01-18 20:27:24','de13025b-7490-49ef-98fc-88d55a19e902'),(129,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'6f4eafae-6128-4926-9d01-224625ab3180'),(130,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'3e0cdbf1-e884-4dfc-b417-3737a3edd823'),(131,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'bcf7d6ab-7873-4d3b-a9a6-2a53b7d003f6'),(132,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'41b9ba3b-ac07-4399-b7a0-b8b0e4616899'),(133,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'68cbaeea-a8f3-4250-876f-c651f6379311'),(134,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'12b63d58-4b50-4a64-93c0-e766854ecd5d'),(135,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'13305b92-dedf-4955-a974-38ca5fa27cca'),(136,NULL,16,30,'craft\\elements\\Entry',1,0,'2016-06-26 00:43:12','2021-01-18 20:27:24',NULL,'6b19e1a8-ab0b-49e4-828c-d250a311c0a1'),(137,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','9256cafb-20b4-40ce-b146-5ed327180515'),(138,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','4da965c1-f1c5-44af-a55f-5814bd53575a'),(139,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','8f95f35d-08a0-4c37-a00f-b3b1ccea4c89'),(140,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','ea977c96-d5ec-4d68-ae7f-4a66de54da2d'),(141,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','88b48f75-3e88-498f-a44d-7d6ac03cd14d'),(142,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','90f5128c-ad3a-40c0-b600-07c638a90665'),(143,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','de9a28b7-cb54-4c14-b3b9-43894c22309e'),(144,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'3e7eeb2b-3bf1-406d-8a55-088f1c607fbf'),(145,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'b13f0ed6-19d0-4a40-9f87-87a91b386fd3'),(146,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'2f3c2529-e176-4088-a1d1-513bfae27456'),(147,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'832fbe0c-c634-46ac-a5a0-0fe6f0490fbd'),(148,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'9af06999-7941-47cb-abc7-39290864c9fe'),(149,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'9d569a81-2ad9-4b5d-bddc-e8989231440a'),(150,NULL,17,30,'craft\\elements\\Entry',1,0,'2016-06-26 00:40:56','2021-01-18 20:27:24',NULL,'344a3a78-d8e9-4e7a-87b2-5c7811d2fe77'),(151,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','fadbe891-3ad0-4fea-95f6-1b0f958a512f'),(152,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','c79c1d8f-181b-4be0-b0b4-85fb47f27475'),(153,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','1e342ee5-a7b3-4636-ba3a-99e4016ac1f4'),(154,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','1a2da568-eb37-4d07-88fa-9a51ccfeebc1'),(155,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','83cdb70f-7224-4fbd-b6e1-c8c285d7fa82'),(156,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','45fa4b15-f63d-4ca0-b0be-146aa75d2192'),(157,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'236619cd-5565-4797-bb4e-abb681a5ed4f'),(158,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'6d3363cd-cfbb-4baa-ad17-01e08485c13d'),(159,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'30585813-8ab1-4295-9ebf-360c3230d47a'),(160,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'27e7ffde-2aa1-465f-9e14-efbdde157cc3'),(161,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'78067466-1fe4-41b4-a633-ae88e7d01ddd'),(162,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'579d6e41-bc2c-4a08-a788-859ee90a1d7d'),(163,NULL,18,30,'craft\\elements\\Entry',1,0,'2016-06-25 02:22:43','2021-01-18 20:27:24',NULL,'18bf329e-1fd8-4caf-b9b7-37e9c7ab830a'),(164,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','0302f9e8-7f43-4bf7-8629-cf4dd2f0c5d0'),(165,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','989e9a08-4061-460b-8374-714eadbffa37'),(166,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','ccd15ca6-81c8-447a-b0eb-3a5b63783bf7'),(167,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','ff11e075-f38b-4d5f-9122-71d1aafd1f84'),(168,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','963ed2ef-9c86-4695-8b63-a726bad3b71c'),(169,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','311a53b1-24d7-4dfc-bcb6-4b6bf7a7de0e'),(170,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'64922d6c-624f-4347-b4a5-ff59c7ff4fe0'),(171,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'20d651ae-e224-4714-ad44-e99b495f4867'),(172,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'9cc43cee-3b13-4d3e-8c47-e82990d2b478'),(173,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'9abb6693-6c09-43d6-a75d-7535b034ef4d'),(174,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'e7d98c37-b810-4344-89de-9fd58868e53d'),(175,NULL,19,30,'craft\\elements\\Entry',1,0,'2016-06-25 02:17:08','2021-01-18 20:27:24',NULL,'3a9d830f-cf41-4820-9d50-b01462efc7bb'),(176,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','ede2bf19-a585-46fe-aac4-12cbea6a13cb'),(177,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','fe393dca-bdf0-480d-8ab4-cf74bcf110e1'),(178,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','f4306fae-9888-47da-9745-0b19fb4bea9b'),(179,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','fece21b0-e206-44b7-9f57-83ba991b6b29'),(180,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','971e5da7-d765-434a-a570-3359afc4518a'),(181,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'ca33af18-42a4-4bc1-a824-abc0a7e1be50'),(182,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'d804b988-b5d9-484f-a947-177a09629bfd'),(183,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'9ad71451-7238-49a2-97d2-db397c1ebf2a'),(184,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'efa9567e-e59f-4ce3-8d31-c54628f3a918'),(185,NULL,20,30,'craft\\elements\\Entry',1,0,'2016-06-25 02:16:44','2021-01-18 20:27:24',NULL,'bdc05830-7901-4e78-a9df-51ef8a2ed688'),(186,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','e3a716b9-1aab-49ed-a656-2b76f8c026ef'),(187,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','dc0ef9cb-ef39-452b-aa3e-c78a5d30125f'),(188,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','ed6e8a67-40d9-4f3a-95f7-fd2b51bc69da'),(189,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2021-01-18 20:27:24','94db7421-c607-40f8-9187-f7903e68584e'),(190,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'15f59781-5abe-49c4-9390-b573139dae51'),(191,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'07423f6d-9951-43e4-8d6d-789a8e852586'),(192,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24',NULL,'20930734-ca05-458f-a639-c0007bf3588b'),(193,NULL,21,17,'craft\\elements\\Entry',1,0,'2016-06-25 02:04:41','2021-01-18 20:27:24',NULL,'530c0488-110d-4b4e-93ca-c5884e6d2125'),(194,NULL,22,17,'craft\\elements\\Entry',1,0,'2016-06-25 02:03:22','2021-01-18 20:27:24',NULL,'f9754bcd-4bae-4f19-9419-643866ffcf84'),(195,NULL,23,21,'craft\\elements\\Entry',1,0,'2016-06-25 02:02:24','2021-01-18 20:27:24',NULL,'017b5f67-ceae-42ca-9a0d-4d60f2da5bbd'),(196,NULL,24,21,'craft\\elements\\Entry',1,0,'2016-06-25 02:02:13','2021-01-18 20:27:24',NULL,'c0db69f5-634f-40a4-92ab-dd2e1361350e'),(197,NULL,25,21,'craft\\elements\\Entry',1,0,'2016-06-25 02:02:03','2016-06-28 23:23:32',NULL,'9cf006b8-24cb-4bd2-a085-f56582fd09e4'),(198,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2021-01-18 20:42:54','2021-01-18 20:43:19','2021-01-18 20:44:12','58f08a86-08e3-4085-abcd-c41b2c1c48d0'),(199,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2021-01-18 20:44:07','2021-01-18 20:44:07',NULL,'4538cba4-301f-4146-9511-9f92f6950b26'),(200,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2021-01-18 20:44:07','2021-01-18 20:44:07',NULL,'4c1aff2d-6bf9-4e1a-bb18-5f74c704cb02'),(201,NULL,NULL,22,'craft\\elements\\Asset',1,0,'2021-01-18 20:44:07','2021-01-18 20:44:07',NULL,'9b438f80-404d-4939-b1d7-327c5c1be635'),(202,NULL,26,30,'craft\\elements\\Entry',1,0,'2021-01-18 20:51:49','2021-01-18 20:51:49',NULL,'cf73ba0c-ea08-4717-bf36-65c0f72e8de4'),(203,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2021-01-18 20:51:49',NULL,'42807325-f0b6-47f9-8216-1315304bef62'),(204,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2016-06-29 03:28:18',NULL,'0b099ef6-fb5b-4662-ab71-4dc01e3efed9'),(205,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2021-01-18 20:51:49',NULL,'df328f58-f7be-462a-a87c-51b3694f80f1'),(206,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2016-06-29 03:28:18',NULL,'350c65df-2206-4625-a0a3-5731c1678e1f'),(207,NULL,NULL,25,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2021-01-18 20:51:49',NULL,'65482a43-aa47-4d6f-a65a-3b7ed8e08354'),(208,NULL,NULL,24,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2016-06-29 03:28:18',NULL,'c0d1f676-6d6b-4ae1-b383-f03ac2d95a40'),(209,NULL,NULL,23,'craft\\elements\\MatrixBlock',1,0,'2021-01-18 20:51:49','2016-06-29 03:28:18',NULL,'abeb7b2c-6b8f-472d-b2b0-6e2dd3d7673f'),(210,NULL,27,21,'craft\\elements\\Entry',1,0,'2021-01-18 20:58:19','2021-01-18 20:58:19',NULL,'4f95cd7e-aea4-4820-bed5-041e96357a43');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements_sites`
--

LOCK TABLES `craft_elements_sites` WRITE;
/*!40000 ALTER TABLE `craft_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements_sites` VALUES (1,1,1,'',NULL,1,'2016-06-24 17:18:51','2016-06-24 17:18:51','65bcbfb7-8c66-4de1-a654-9ff34f7ec44a'),(2,2,1,'homepage','__home__',1,'2016-06-24 17:18:55','2016-06-24 17:18:55','a0516527-5b91-48dd-80f2-670cd395ce3b'),(4,4,1,'cms-statamic',NULL,1,'2016-06-25 02:01:29','2016-06-25 02:01:29','e1d7292b-75f7-4285-bd3c-e8975482bd10'),(5,5,1,'26','podcast/26',1,'2016-06-25 02:02:03','2016-06-28 23:23:32','36e861d2-e26d-4f13-b462-7b9d193f408d'),(6,6,1,'a-link-to-a-great-article','blog/2016/06/a-link-to-a-great-article',1,'2016-06-25 02:03:22','2016-06-26 01:58:58','60486eba-0654-475c-93d5-f020e1de58d8'),(7,7,1,'another-link-to-an-interesting-article','blog/2016/06/another-link-to-an-interesting-article',1,'2016-06-25 02:04:40','2016-06-26 01:58:58','225a6ed8-d861-4e28-846a-fe11f4574b30'),(8,8,1,'pioneer-10-nasa-flickr-commons',NULL,1,'2016-06-25 02:16:00','2016-06-25 02:16:00','2a2534c7-cc14-43eb-a859-8be35b518714'),(9,9,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2016-06-25 02:16:44','2016-06-29 03:28:18','97720304-f21d-4983-becc-d05eda27529d'),(10,10,1,'',NULL,1,'2016-06-25 02:16:44','2016-06-29 03:28:18','c865e970-4b38-4173-bd19-ca20147d525f'),(11,11,1,'',NULL,1,'2016-06-25 02:16:44','2016-06-29 03:28:18','fa8676e7-59ca-4d1a-a3e1-cb392a5d776b'),(12,12,1,'',NULL,1,'2016-06-25 02:16:44','2016-06-29 03:28:18','de24c3ff-2cae-4eb1-b793-0da86ea767c2'),(13,13,1,'',NULL,1,'2016-06-25 02:17:08','2016-06-29 03:28:18','ce4cff9e-cf66-4521-95b6-bc42979caba6'),(14,14,1,'pioneer-missions',NULL,1,'2016-06-25 02:22:30','2016-06-25 02:22:30','d2e4dbbd-183e-4f1b-ade9-cd0cf80540d8'),(15,15,1,'',NULL,1,'2016-06-25 02:22:42','2016-06-29 03:28:18','9a2ef378-4cc4-4454-8369-8d239b355d72'),(16,16,1,'',NULL,1,'2016-06-26 00:40:56','2016-06-29 03:28:18','e2eef82f-5532-490b-b0b3-cb4283b1ca3e'),(17,17,1,'',NULL,1,'2016-06-26 00:44:58','2016-06-29 03:28:18','8a46263d-d6a6-469c-96b6-7b7f6f8aac05'),(18,18,1,'this-is-a-review','review/this-is-a-review',1,'2016-06-27 19:21:57','2016-06-28 22:51:09','00d8d192-7060-4372-836f-aa031009dbb7'),(19,19,1,'',NULL,1,'2016-06-27 19:21:57','2016-06-28 22:51:09','947b8c0f-d7b2-4895-993c-8ffeab59071f'),(20,20,1,'',NULL,1,'2016-06-27 19:21:57','2016-06-28 22:51:09','dbabbc90-6c60-4484-a327-dffb62e03776'),(21,21,1,'',NULL,1,'2016-06-27 19:21:57','2016-06-28 22:51:09','8f37e8bf-2f89-4407-a10a-bcdeed5bb50c'),(22,22,1,'pioneer10',NULL,1,'2016-06-28 22:58:18','2016-06-28 22:58:18','e8cb3163-c527-472a-96f9-23b2aaf35814'),(23,23,1,'retrospective',NULL,1,'2016-06-28 22:58:22','2016-06-28 22:58:22','d93e04c3-9b4f-492f-96ab-48332112a21b'),(24,24,1,'homepage','__home__',1,'2021-01-18 20:25:27','2021-01-18 20:25:27','886c9594-5baf-4b5f-bfed-edee2041ee00'),(25,25,1,'homepage','__home__',1,'2021-01-18 20:25:27','2021-01-18 20:25:27','49501fb9-1720-441e-8c9d-163e28ce0c4b'),(26,26,1,'homepage','__home__',1,'2021-01-18 20:25:28','2021-01-18 20:25:28','cb3d88cc-385b-4fbf-ae4e-21d4e1695a6e'),(27,27,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','7fda5271-c86d-421f-a228-4a31127be542'),(28,28,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','25ff7882-5e7f-4034-92b3-163642aef4d7'),(29,29,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','e88cb96f-a340-49c6-9514-cc2ef212349c'),(30,30,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','967ea553-e371-4a27-9330-ee3e732ecbe8'),(31,31,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','e4cecb0d-4eab-4fb7-b689-604c19a47b9f'),(32,32,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','41f7724c-76e4-4039-9a93-f600eaa80059'),(33,33,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','eedf8f6c-43f2-4f5f-8b61-81e77f900c82'),(34,34,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','c00a613e-e7d0-4e0d-9f86-3e3a6cccc71a'),(35,35,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','00d905d7-b662-4bd9-89bf-44957bbc9c76'),(36,36,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','c5323704-505f-4f77-9a7c-27a5f68c3745'),(37,37,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ee4ef03f-3077-49db-a48f-4aafa707188c'),(38,38,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','e5991fbc-47a7-4984-bdba-5efe23e3b22f'),(39,39,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','5a4ac36b-45ca-4531-8adf-6b8b5d994b36'),(40,40,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8504e6ce-11e9-41de-90e8-839c66e2d5d3'),(41,41,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a4bd6e63-86fc-4337-afbd-4376ed7f0061'),(42,42,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8e5d27b4-dbe6-4f96-8042-c992d59af2ce'),(43,43,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','73295a85-1c9e-4c57-acc9-6826b5c1f2f6'),(44,44,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','985d1d65-f211-450c-a411-deb4ef3a5e52'),(45,45,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d9b5e9a6-80e4-47bc-a416-f4ced0440cd6'),(46,46,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','00f30e54-26cd-438b-9983-de0dbbd1b276'),(47,47,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','948b69e0-65e1-482c-9038-10ae04542f9a'),(48,48,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','febd4d11-7a06-465b-b8d5-f75c0fe20632'),(49,49,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','fc14922d-86d5-429e-94fc-c3d357131ca6'),(50,50,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','994134b7-8b2c-49d1-9f07-c14ee19b1632'),(51,51,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','839a8f2e-195c-43b0-94b6-4d742b386a70'),(52,52,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','3aead1c8-7121-4cee-878d-c0dab414e384'),(53,53,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','153b9e94-94fd-4ff3-b3cc-c0783c9bf121'),(54,54,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','3c3e34ee-f33e-4127-a813-0411b0d0e98d'),(55,55,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','649bae0d-78ce-4b37-9cab-fb32b9922c92'),(56,56,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','31caffbc-cff1-4c2f-a331-c2da8406d3d0'),(57,57,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ec5dc768-8d87-4ea1-8796-9942d5070075'),(58,58,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','13433354-c5bd-4cd7-b865-0c5f7ec008e9'),(59,59,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','57c7a808-c751-42b1-90e3-0cb5f91633bb'),(60,60,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','db3d6a24-ea42-4771-8e8c-b6601ea8160d'),(61,61,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','6bdf84ef-45dc-4813-83db-c77ab8f3c960'),(62,62,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','2d0e6487-512f-4039-91cf-2f0bf6991254'),(63,63,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','98b70afd-05ff-4794-89d2-a075b0923a9f'),(64,64,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','cffcdb1a-df56-43ed-b284-3b3ba2ec61a1'),(65,65,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','b80e6475-a3b7-4da0-bd7d-f7e135d3e93b'),(66,66,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','13a32088-59a8-41f2-bb14-404ce1704e8c'),(67,67,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','afd7439b-505a-46c4-a1cc-a5e7e515c570'),(68,68,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','77c8f656-0618-4d5d-916d-32dac4fef43c'),(69,69,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','785071a7-498a-4d00-adc0-ae2445315fb9'),(70,70,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','6afab872-e15d-43cc-8589-25f7645865aa'),(71,71,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','9a86d53e-5a83-4192-9473-5a743d061e5d'),(72,72,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','11b88cb1-8197-441a-a06f-92f65ef577f5'),(73,73,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','4c62d484-8c0e-444d-8d05-57a91c0921bd'),(74,74,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ec0d6d85-ccaf-4804-aa4c-8d39c11ce0b5'),(75,75,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','c4ab4f87-7786-40ed-b80c-1912058d0122'),(76,76,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','802894c0-75f5-419f-8133-213ed1d2ff0d'),(77,77,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','cfe6e0e6-4dfd-4931-9f42-249c68588864'),(78,78,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','991a66ab-9a4a-4590-87da-a6cc56f08e8d'),(79,79,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','bc26ec7e-e048-4f87-ba80-38b09ec03967'),(80,80,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','bdeb434a-5145-4fd3-8b43-95f1f92085b6'),(81,81,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','313b0c84-b745-4d04-9ade-240bf6e9f980'),(82,82,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','32cb1076-940e-4ba9-9ccc-094a9490ba8f'),(83,83,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','f25ecb76-2522-4275-bff5-5b92cbf44a93'),(84,84,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ec17933e-3c4c-4cc8-8588-d2515d677df3'),(85,85,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','734329eb-066b-42f2-9353-2859defd9487'),(86,86,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','50be959a-f48b-4ccc-8851-fcd4cd8127d4'),(87,87,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','64fb9cc9-9ab9-4da7-839a-5835411ce1f7'),(88,88,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8b822827-61ac-4c4b-9bb0-0ceab77c7f20'),(89,89,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','bf3108f1-3904-498f-b17e-1bec40777cd3'),(90,90,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','b2cd3c75-809a-4e63-ba5b-34f40e81daff'),(91,91,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','855e17fe-fcaa-4d4e-87f5-dbd6d9b1d01c'),(92,92,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','38c47eb2-9e96-4a05-93fb-2e705587f648'),(93,93,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','749c334d-7b63-4d2d-a92e-a578a9e7ccfa'),(94,94,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','52a4549d-0b8c-451e-977a-8995f9d1f0eb'),(95,95,1,'26','podcast/26',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','9f4623c5-4904-42bd-8150-210313a20859'),(96,96,1,'26','podcast/26',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1102f7b6-8c9e-455e-b8f1-546f306c8b6b'),(97,97,1,'1','podcast/26',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','fe58ee05-3054-47e9-90d5-62752d323d1f'),(98,98,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a77489f9-c6dd-4a70-8588-0d5fcb7fd4fa'),(99,99,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d4f68eba-0f85-407e-8676-f1865bab8640'),(100,100,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','127402cc-ae7d-45ff-9156-f1ff67ae7639'),(101,101,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ab8f976b-3d73-4306-a8b0-004b91966019'),(102,102,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','fa8a227a-f2e9-479f-b32b-8f59e5075141'),(103,103,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8f9fdf0b-4747-4825-8403-e537a32252ab'),(104,104,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','58e0ccda-7219-46da-8be6-71fa171b2191'),(105,105,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8a202191-0786-4b4d-90e0-1add23702ed8'),(106,106,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d9874b0c-6ceb-429a-9cc7-dc7a9e3aa2fb'),(107,107,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','fec62d72-a383-4aeb-ac7b-82cf61f4e075'),(108,108,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','613ff534-c8b7-4ab4-a22c-a88e4c34e803'),(109,109,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','c51b696a-c954-4743-9434-37142d3e3c91'),(110,110,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','979f3820-7896-4748-99cf-d9a8cc254eea'),(111,111,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','f0760099-2b32-4ed1-b20c-cf7a446e88a1'),(112,112,1,NULL,NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ca75151b-2d33-4400-a0ac-8e15f31699ca'),(113,113,1,'this-is-a-review','review/this-is-a-review',1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d2922231-d485-4219-8f37-9af74e03b81b'),(114,114,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1b3ec9bf-833e-4a7f-8fb5-17392f9af71f'),(115,115,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a637b637-30bc-4292-bf33-3cb1dac39964'),(116,116,1,'',NULL,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','842d0135-413c-40ac-80ad-e329ecb0e224'),(117,117,1,'this-is-a-review','review/this-is-a-review',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','321c5fd4-6d2e-4284-8906-0cccf879f162'),(118,118,1,'',NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e4f992c4-a966-44ee-ae8b-6b8d130a696c'),(119,119,1,'',NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','c4303d94-575f-47c7-bfb4-16aeef10a0f7'),(120,120,1,'',NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','b4dd3226-5ed9-4141-91a6-2e46bbb13410'),(121,121,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4225bf26-106e-4a58-a742-08a08baf6897'),(122,122,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9a1b4141-4312-4a20-a004-33823d40da6d'),(123,123,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','61dd4e7c-0717-431c-a243-76fb5c8c775c'),(124,124,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5df79dd9-8c7d-4ca5-afc6-333c70ac4f45'),(125,125,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','1147be60-5872-4452-b1b2-e819713c8fa5'),(126,126,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','bffe361b-4396-4483-ac68-6cb6547245d8'),(127,127,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','fcf154b5-5021-4cc4-9cf5-a7f2f4302e90'),(128,128,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','590a2482-efd6-40e2-8863-9e35ee86c2a5'),(129,129,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','1755167a-0876-49e8-b219-180cbd50a5f0'),(130,130,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9c17288c-34dd-4a61-9ea4-14d39dfe2ec1'),(131,131,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a40a0cda-aa3b-4ce5-8999-44908d924023'),(132,132,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e1ca8c7b-ce79-4b04-ae16-e48eef04691d'),(133,133,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','7664bfda-63e3-4f3c-a87d-7ebc052d4ebe'),(134,134,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5fecc918-2f55-4f2e-a53e-472613c40be4'),(135,135,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a729f659-3636-4127-a02c-7f0b6676afc7'),(136,136,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9bcbcaef-8e9f-402d-8e0f-645ccd4b5169'),(137,137,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','43433ec2-8212-4853-8822-90c135097fdc'),(138,138,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','3c9b6b07-e6e3-4947-9410-fdeb751e90e5'),(139,139,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','89dc38c3-daf6-44ff-b87d-8200e0c9971b'),(140,140,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','fdc7eacd-23a8-4c36-a732-c2c239ea83a3'),(141,141,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','941847a7-5ccb-4877-8c82-1b6e93450b78'),(142,142,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','0008195f-9939-41e4-92d8-5a15ea98cfa5'),(143,143,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','240b5eec-009f-4602-bea3-3fb3bdc2c66f'),(144,144,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','07a58665-1830-449e-9ccd-9f959d371ed8'),(145,145,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','118f5e5c-973e-4df3-b72b-a01905afbdb2'),(146,146,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','eb00fe82-dfc0-4882-8e4e-e4614d09cb82'),(147,147,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','085a60b2-a7bf-4135-8b3f-5fec161551ea'),(148,148,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','582a4044-f007-4778-b66b-9969dccb901b'),(149,149,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','7eff3ff7-899b-4fb4-be74-7745744a5949'),(150,150,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','675ebb16-db22-45db-9704-8220ddb566a9'),(151,151,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4e5a16aa-b26f-4bd3-b23d-d03c618a507a'),(152,152,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','6c921110-0e0c-4ad3-8f8f-af492920fba8'),(153,153,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','40d82c8b-63c4-430a-afb0-cb8009e32b51'),(154,154,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','1c6373bb-fb95-4ebe-a9b5-a5d6a93d284a'),(155,155,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','dce5337b-3b12-46cf-8fc3-b707db5f3d96'),(156,156,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','572d09a2-af95-44e3-a78e-029131fd38d6'),(157,157,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','69b6083c-33dd-4eb3-8ae8-6cd019657fc2'),(158,158,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','30f7d4ef-9cfe-4c07-8757-8dad9336ddfd'),(159,159,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','3efa7134-eeec-4819-95bd-973eb7b7ec19'),(160,160,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9b1a53c7-e378-499c-8e0c-bf3fb05e8823'),(161,161,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','67e30229-797d-4f9a-bbf2-2aceb7d41195'),(162,162,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e2b911cc-9d6e-4b16-9c6e-b377855ca6fc'),(163,163,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ca45ccc0-b929-4eb4-9cc0-2996276f9cf9'),(164,164,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5160bf8f-c32f-4621-959b-b43a9d9dea85'),(165,165,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','61f38992-80d8-4a12-9ab2-37eaf05e7190'),(166,166,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','8c3c5472-057e-42bf-b03d-61f6fcae4523'),(167,167,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','20ef4726-5199-4aa4-ab74-a5df12b85c5a'),(168,168,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','aa315a92-4ed3-4f82-b079-6d0c47e69770'),(169,169,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','70848c42-a4d8-4400-8747-e84556f47a38'),(170,170,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9e2cc3a9-74a8-44ef-91fe-21c7221446b4'),(171,171,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','fa9b4346-5b4b-4495-a359-0a5e7c38f9e8'),(172,172,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4fce2c2e-6b43-4358-958a-d375ec5e47c7'),(173,173,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a2ccb4c0-cb40-4ce7-96fe-d4522a5c24d4'),(174,174,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','03d9cecf-63d0-4b27-8f73-70ca4ad78440'),(175,175,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','445a12cb-3403-4e08-ada3-c0a2471f47a9'),(176,176,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','cc84dfef-541e-4660-a0b3-14b275e41cf7'),(177,177,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','d3bba3e3-8fd0-47da-8e48-ccb777e4120d'),(178,178,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','f1682a6b-c684-4974-9289-c777c9cf1449'),(179,179,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ffc9e7f4-2a28-4458-b4f6-bb9f374ec43c'),(180,180,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','b5086014-e793-4d2c-a842-d46d1a2686bd'),(181,181,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','79a9fd02-1d6f-47b9-ad49-bb40c3ff2044'),(182,182,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','c167bc02-c2b2-471e-a72b-8685f63c77bd'),(183,183,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','145e79dd-1a99-4b00-9096-0471203b20ca'),(184,184,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','f1da877b-26c2-4e64-a354-355caa0bb0fd'),(185,185,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ca5661c6-86a6-4994-9b3e-488f7aad5541'),(186,186,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','c9c59f30-ea5a-4976-9053-581171ea9051'),(187,187,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4e2eb959-488d-4869-a46e-241da2b2d895'),(188,188,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9c4d27c9-33bc-4343-9662-bf6efb0c80b7'),(189,189,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','51bac193-f03b-4c71-ac5d-bb6cfc394010'),(190,190,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e9f20105-35d3-4f9d-8412-f1bef2f23aba'),(191,191,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4335d7e2-c928-4962-b406-a794271228e7'),(192,192,1,NULL,NULL,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','b5a48f64-2eed-4f8c-bf6c-7825bef52537'),(193,193,1,'another-link-to-an-interesting-article','blog/2016/06/another-link-to-an-interesting-article',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a23e881f-a46a-472c-8bbc-6dfd13134295'),(194,194,1,'a-link-to-a-great-article','blog/2016/06/a-link-to-a-great-article',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','136ca823-c25d-4f55-bf3b-ed07edf27d05'),(195,195,1,'1','podcast/26',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a4f62e76-713b-4aeb-ba24-be9db739cbcf'),(196,196,1,'1','podcast/26',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','9d10ea68-f674-4982-b761-9c249425553f'),(197,197,1,'26','podcast/26',1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e9a8db9c-cf98-4baa-9ab4-190fe6caf99b'),(198,198,1,NULL,NULL,1,'2021-01-18 20:42:54','2021-01-18 20:42:54','b24a540f-e9dd-40a5-a47e-e44ecdf20f97'),(199,199,1,NULL,NULL,1,'2021-01-18 20:44:07','2021-01-18 20:44:07','b41e9398-9a56-445c-a543-0e7546ff9135'),(200,200,1,NULL,NULL,1,'2021-01-18 20:44:07','2021-01-18 20:44:07','0322cc85-974d-408c-b4cd-de6f68e22244'),(201,201,1,NULL,NULL,1,'2021-01-18 20:44:07','2021-01-18 20:44:07','7db5e20b-d698-4b83-94a5-c4c1afd5081e'),(202,202,1,'back-in-time-pioneer-10','blog/2016/06/back-in-time-pioneer-10',1,'2021-01-18 20:51:49','2021-01-18 20:51:49','a965deb9-e041-4f2c-8c81-8416192caab5'),(203,203,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','881402e7-d416-4110-b74b-013c47215f15'),(204,204,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','3e527292-91b4-4ff4-86a1-82ad53c10393'),(205,205,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','4bfceeb1-ba78-4887-af66-0158732af8ab'),(206,206,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','2b9d43f8-569f-447c-bd94-212b99d4e8db'),(207,207,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','c6ea4726-1fe4-4004-88fe-95477e20c4ca'),(208,208,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','5ae5095e-a15d-4847-8696-9f7dcaa97302'),(209,209,1,'',NULL,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','6edf3d0a-9af6-4f8a-8849-eee46baee592'),(210,210,1,'26','podcast/26',1,'2021-01-18 20:58:19','2021-01-18 20:58:19','13e0ac3e-5fff-489d-8500-15164d828ea0');
/*!40000 ALTER TABLE `craft_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entries` VALUES (2,1,NULL,1,NULL,'2016-06-24 17:18:55',NULL,NULL,'2016-06-24 17:18:55','2016-06-24 17:18:55','2e4bc58f-f1ce-4593-a024-18d93a715dc9'),(5,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2016-06-25 02:02:03','2016-06-28 23:23:33','952d23ef-85a8-42cb-b4ca-7d2cdfa74199'),(6,4,NULL,5,1,'2016-06-25 02:03:21',NULL,NULL,'2016-06-25 02:03:22','2016-06-25 02:03:22','3a2cafcc-3c49-4b07-a5d1-52074968499f'),(7,4,NULL,5,1,'2016-06-25 02:04:40',NULL,NULL,'2016-06-25 02:04:41','2016-06-25 02:04:41','9507e3be-6493-49e2-af79-d3f39ef520e3'),(9,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2016-06-25 02:16:44','2016-06-29 03:28:18','857889be-8c1b-40cf-9ee4-77a67af84870'),(18,6,NULL,7,1,'2016-06-27 19:21:00',NULL,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','523b5537-f381-415d-bf56-1a03597c2e0d'),(24,1,NULL,1,NULL,'2016-06-24 17:18:55',NULL,NULL,'2021-01-18 20:25:27','2021-01-18 20:25:27','1d24cab2-f865-447d-8a44-8f339b970fc5'),(25,1,NULL,1,NULL,'2016-06-24 17:18:55',NULL,NULL,'2021-01-18 20:25:27','2021-01-18 20:25:27','b8b6484c-d0ea-4d33-931e-b868c6c76ebd'),(26,1,NULL,1,NULL,'2016-06-24 17:18:55',NULL,NULL,'2021-01-18 20:25:28','2021-01-18 20:25:28','bc29d60c-8038-47d5-a087-ebd06391820c'),(27,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','35848482-202a-40ba-97ca-22d420cca323'),(35,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','20037e7d-852d-4833-ae68-0d61ef28af90'),(50,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','3cffa53d-01ee-41f8-bb39-7879d1aa66db'),(65,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','1cef0d74-1430-498a-a61f-57c94a93d67f'),(80,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','ca9a41e2-6c2e-4852-b171-8b130e61c65b'),(95,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c72262cd-f5e5-4e5c-b88b-6889928fc322'),(96,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','fad974d4-1dec-4aa9-a351-814fb7801314'),(97,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','d753f963-5ac6-4af2-8b07-56f426860b46'),(98,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','63f63460-75e7-4f8d-b607-ceffd2a1b530'),(113,6,NULL,7,1,'2016-06-27 19:21:00',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','3df74330-7e23-438d-80e8-9c038136b0c9'),(117,6,NULL,7,1,'2016-06-27 19:21:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','7291d6e1-a619-4c93-b7d8-a9d4801d4870'),(121,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','366cf337-8e39-4529-af3e-bc12edf5eecf'),(136,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','b431635e-c0be-417b-b964-179901cf9796'),(150,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','4c88f8cf-b4a9-4c33-a7f6-8b71a26d2a4b'),(163,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','91cceb77-72c3-49c9-a158-b275bf73247a'),(175,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','8c392dd3-9103-489e-9930-98bf692b288e'),(185,4,NULL,4,1,'2016-06-25 02:16:44',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','99bde846-27e6-4fbc-8c24-aa204da76fee'),(193,4,NULL,5,1,'2016-06-25 02:04:40',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','1e3a2bd7-e4f8-47dd-a15b-d6ef53aa11c6'),(194,4,NULL,5,1,'2016-06-25 02:03:21',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','498f6bf3-82d4-47dd-bc27-787faa741702'),(195,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','82e5ee99-5d09-4daa-bd3b-369d98c4cf8d'),(196,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','19548186-e12c-49d9-9edd-60b3d2da11f8'),(197,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','057d5d56-1d76-43ba-8b61-7c34ea012729'),(202,4,NULL,4,1,'2016-06-25 02:16:00',NULL,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','9fe28160-90fb-47f9-acbb-1e818ab306d9'),(210,3,NULL,3,1,'2016-06-25 02:02:00',NULL,NULL,'2021-01-18 20:58:19','2021-01-18 20:58:19','0ef8aee5-e3c7-4d39-b4fc-1f09123cd3a3');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafterrors`
--

LOCK TABLES `craft_entrydrafterrors` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafterrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafterrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entrytypes` VALUES (1,1,3,'Homepage','homepage',1,'site',NULL,NULL,NULL,'2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'5610066d-2f20-4444-a547-eb560bda26a5'),(3,3,21,'Default','default',1,'site',NULL,NULL,NULL,'2016-06-24 18:35:04','2016-06-25 01:59:36',NULL,'86d15507-220a-4d5c-b1d0-eab2b173619f'),(4,4,30,'Default','default',1,'site',NULL,NULL,NULL,'2016-06-24 20:17:29','2016-06-29 03:12:26',NULL,'a95fdc3d-b143-489a-8ee7-22ae7268c278'),(5,4,17,'Link','link',1,'site',NULL,NULL,NULL,'2016-06-24 21:19:49','2016-06-24 21:26:01',NULL,'c1d8279b-ea8f-4690-9ecf-97c82d6f64ca'),(7,6,28,'Default','default',1,'site',NULL,NULL,NULL,'2016-06-27 19:20:18','2016-06-28 22:44:49',NULL,'e1d02456-6cc1-4385-9e98-73bd2a5e4abf');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversionerrors`
--

LOCK TABLES `craft_entryversionerrors` WRITE;
/*!40000 ALTER TABLE `craft_entryversionerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entryversionerrors` VALUES (1,14,'Entry is missing its type ID'),(2,3,'Entry is missing its type ID'),(3,2,'SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry \'2-3\' for key \'craft_revisions.craft_revisions_sourceId_num_unq_idx\'\nThe SQL being executed was: UPDATE `craft_revisions` SET `num`=`num`+2 WHERE (`sourceId`=2) AND (`num` >= \'1\')'),(4,1,'SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry \'2-2\' for key \'craft_revisions.craft_revisions_sourceId_num_unq_idx\'\nThe SQL being executed was: UPDATE `craft_revisions` SET `num`=`num`+1 WHERE (`sourceId`=2) AND (`num` >= \'1\')');
/*!40000 ALTER TABLE `craft_entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entryversions` VALUES (1,2,1,1,1,1,NULL,'{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1466788735,\"expiryDate\":null,\"enabled\":1,\"newParentId\":null,\"fields\":[]}','2016-06-24 17:18:55','2016-06-24 17:18:55','544c04ae-4dd3-4d4b-81ca-8ab82d3f8e12'),(2,2,1,1,1,2,NULL,'{\"typeId\":null,\"authorId\":null,\"title\":\"Welcome to Downlinkpodcast.dev!\",\"slug\":\"homepage\",\"postDate\":1466788735,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"1\":\"<p>It\\u2019s true, this site doesn\\u2019t have a whole lot of content yet, but don\\u2019t worry. Our web developers have just installed the CMS, and they\\u2019re setting things up for the content editors this very moment. Soon Downlinkpodcast.dev will be an oasis of fresh perspectives, sharp analyses, and astute opinions that will keep you coming back again and again.<\\/p>\"}}','2016-06-24 17:18:55','2016-06-24 17:18:55','8ed61765-6d4e-4c66-b1e4-9c7dc5b1f304'),(3,5,3,1,1,1,'','{\"typeId\":null,\"authorId\":\"1\",\"title\":\"Just Krause of Asana\",\"slug\":\"just-krause-of-asana\",\"postDate\":1466820122,\"expiryDate\":null,\"enabled\":1,\"newParentId\":null,\"fields\":{\"11\":\"<p>Justin Krause of Asana kindly stepped away from part of his day to talk to me about Statamic and how they use it for the marketing and content sites at Asana. Statamic is a flat file, database-less CMS. All of the website data, settings, and content are stored in files.<\\/p>\",\"13\":[\"4\"]}}','2016-06-25 02:02:03','2016-06-25 02:02:03','04ecbe72-b0e8-429e-a0b7-2608e529bfcf'),(14,18,6,1,1,1,'','{\"typeId\":null,\"authorId\":\"1\",\"title\":\"This is a Review\",\"slug\":\"this-is-a-review\",\"postDate\":1467055317,\"expiryDate\":null,\"enabled\":1,\"newParentId\":null,\"fields\":{\"1\":{\"new3\":{\"type\":\"image\",\"enabled\":\"1\",\"fields\":{\"image\":[\"14\"],\"caption\":\"Pioneer Missions Poster, NASA Flickr Commons\",\"layout\":\"left\"}},\"new1\":{\"type\":\"text\",\"enabled\":\"1\",\"fields\":{\"textContent\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<\\/p>\\r\\n\\r\\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?<\\/p>\\r\\n\\r\\n<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.<\\/p>\"}},\"new2\":{\"type\":\"blockquote\",\"enabled\":\"1\",\"fields\":{\"quote\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<\\/p>\",\"citation\":\"Ryan Irelan, Mijingo\"}}}}}','2016-06-27 19:21:57','2016-06-27 19:21:57','37c4af38-4408-439d-828e-a668a966e5c1');
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_feedme_feeds`
--

LOCK TABLES `craft_feedme_feeds` WRITE;
/*!40000 ALTER TABLE `craft_feedme_feeds` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_feedme_feeds` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldgroups` VALUES (1,'Default','2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'f445487e-f6a2-471c-a08b-3096f57da2d0'),(2,'Podcast','2016-06-25 01:49:02','2016-06-25 01:49:09',NULL,'d6dcd64b-f047-48ff-9336-a67a6c8f8541'),(3,'Review','2016-06-28 22:43:12','2016-06-28 22:43:12',NULL,'183cebdb-02fe-4dd5-8b3e-450522d38342');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayoutfields` VALUES (1,3,1,1,1,1,'2016-06-24 17:18:55','2016-06-24 17:18:55','e42641b4-1b60-4318-bf3b-133a2ce717ea'),(16,17,9,9,0,1,'2016-06-24 21:26:01','2016-06-24 21:26:01','6aa5e2c5-9cd2-4781-9413-bdd829282aa2'),(17,17,9,10,0,2,'2016-06-24 21:26:01','2016-06-24 21:26:01','f7e3270f-4c50-45d2-8223-292f61bf4b89'),(20,21,11,13,0,1,'2016-06-25 01:59:36','2016-06-25 01:59:36','2cdf92ab-5c47-465b-99b2-47e9ffecef8e'),(21,21,11,11,0,2,'2016-06-25 01:59:36','2016-06-25 01:59:36','8ed631cb-d357-4591-ac86-f0811ebb3895'),(22,23,12,3,0,1,'2016-06-25 02:15:06','2016-06-25 02:15:06','300f09bf-ef0e-4dd8-8e65-7da4a5feee23'),(23,24,13,4,0,1,'2016-06-25 02:15:06','2016-06-25 02:15:06','d9e4ce63-8b1f-4fa4-bc0a-0488a0caf44d'),(24,24,13,5,0,2,'2016-06-25 02:15:06','2016-06-25 02:15:06','cff53d38-4a9d-49d5-8c61-bf6b2798851d'),(25,25,14,6,1,1,'2016-06-25 02:15:07','2016-06-25 02:15:07','1f93789d-e55f-43e9-9e88-9e788a4d31b9'),(26,25,14,7,0,2,'2016-06-25 02:15:07','2016-06-25 02:15:07','ee8fce4f-bdc1-4926-97e4-3558e8d10b82'),(27,25,14,8,0,3,'2016-06-25 02:15:07','2016-06-25 02:15:07','ef5bdd9f-402c-406b-a6eb-3ca75583731b'),(29,28,16,1,0,1,'2016-06-28 22:44:49','2016-06-28 22:44:49','d5ab0f35-9180-4fa6-965f-cc8570d65f84'),(30,28,16,14,0,2,'2016-06-28 22:44:49','2016-06-28 22:44:49','dca8aeee-c6d2-458b-b9d9-296d776b8a1a'),(34,30,18,16,0,1,'2016-06-29 03:12:26','2016-06-29 03:12:26','89c3f95a-b531-416d-be2a-3a18b9873ebc'),(35,30,18,15,0,2,'2016-06-29 03:12:26','2016-06-29 03:12:26','0af8c759-dfb1-4d52-bee0-d902370355c8'),(36,30,18,1,0,3,'2016-06-29 03:12:26','2016-06-29 03:12:26','0305b3a2-6a69-4433-aedf-06ae896e1eb9'),(37,30,18,2,0,4,'2016-06-29 03:12:26','2016-06-29 03:12:26','f33d9d34-d356-4517-8f9a-22c1f4026a0d');
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayouts` VALUES (1,'craft\\elements\\Tag','2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'12ef10ac-db7d-4759-814d-1487de411ae3'),(3,'craft\\elements\\Entry','2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'fa1fa13e-dfac-40f6-8fe5-5066b6e2510f'),(17,'craft\\elements\\Entry','2016-06-24 21:26:01','2016-06-24 21:26:01',NULL,'02708298-ea20-41d0-a674-6fba7a7d8c0c'),(20,'craft\\elements\\Asset','2016-06-25 01:58:09','2016-06-25 01:58:09',NULL,'48315f31-0ea0-44ad-a10e-31db5ffb0cf0'),(21,'craft\\elements\\Entry','2016-06-25 01:59:36','2016-06-25 01:59:36',NULL,'d64a50e0-3937-4444-a8f4-1173a41390a0'),(22,'craft\\elements\\Asset','2016-06-25 02:14:14','2016-06-25 02:14:14',NULL,'ab7aac97-56c9-42b8-aacf-bcff9c1ebd85'),(23,'craft\\elements\\MatrixBlock','2016-06-25 02:15:06','2016-06-25 02:15:06',NULL,'ae2817ec-1083-4a4d-b4bb-0a2d71acac2c'),(24,'craft\\elements\\MatrixBlock','2016-06-25 02:15:06','2016-06-25 02:15:06',NULL,'17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a'),(25,'craft\\elements\\MatrixBlock','2016-06-25 02:15:07','2016-06-25 02:15:07',NULL,'6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40'),(28,'craft\\elements\\Entry','2016-06-28 22:44:49','2016-06-28 22:44:49',NULL,'e400c5e4-326e-47e1-9074-cc4a1de24b82'),(30,'craft\\elements\\Entry','2016-06-29 03:12:26','2016-06-29 03:12:26',NULL,'2b9c7d28-9188-4b33-812c-932cd13f32ca'),(31,'craft\\elements\\Asset','2021-03-02 19:47:51','2021-03-02 19:47:51',NULL,'3c2f7dee-7177-4442-957e-e9c8ed0f93a5');
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldlayouttabs` VALUES (1,3,'Content',NULL,1,'2016-06-24 17:18:55','2016-06-24 17:18:55','b7c4489a-14b3-4b8f-b7f6-f65e25ebdc3e'),(9,17,'Link Content',NULL,1,'2016-06-24 21:26:01','2016-06-24 21:26:01','f8d17f95-0f92-4472-825a-ccf0808dc70d'),(11,21,'Podcast Details',NULL,1,'2016-06-25 01:59:36','2016-06-25 01:59:36','ed37f97c-80a9-4cf5-aca3-06b5e438f801'),(12,23,'Content',NULL,1,'2016-06-25 02:15:06','2016-06-25 02:15:06','25a4f662-835a-401a-a147-f2efdc644295'),(13,24,'Content',NULL,1,'2016-06-25 02:15:06','2016-06-25 02:15:06','a567c6d7-743d-4376-9d55-5a1869bc0caa'),(14,25,'Content',NULL,1,'2016-06-25 02:15:07','2016-06-25 02:15:07','73307f61-5a82-43e2-95ec-8aef611b6250'),(16,28,'Review Content',NULL,1,'2016-06-28 22:44:49','2016-06-28 22:44:49','98e3e7c6-2d18-4547-ac4d-b8a741d4e8a7'),(18,30,'Default',NULL,1,'2016-06-29 03:12:26','2016-06-29 03:12:26','71932589-8951-46ab-b39c-f670764f2e1a'),(26,31,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-03-02 19:47:51','2021-03-02 19:47:51','3264808e-4285-4d98-ae68-e09a3df3ef72'),(34,22,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-03-02 20:02:32','2021-03-02 20:02:32','8a883ef2-727d-422d-8354-32e695432544'),(35,20,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-03-02 20:02:32','2021-03-02 20:02:32','1127ef8e-7ab3-48f0-b64f-29c4c2aec020');
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fields` VALUES (1,1,'Body','body','global','',1,'none',NULL,'craft\\fields\\Matrix','{\"maxBlocks\":null,\"propagationMethod\":\"all\",\"contentTable\":\"{{%matrixcontent_body}}\"}','2016-06-24 17:18:55','2016-06-25 02:15:06','f4696807-fad3-4e93-a26a-e1946637d383'),(2,1,'Tags','tags','global',NULL,1,'none',NULL,'craft\\fields\\Tags','{\"source\":\"taggroup:237da2ff-504f-4e2c-bf6c-152bf831c8f1\",\"localizeRelations\":false}','2016-06-24 17:18:55','2016-06-24 17:18:55','b72c1e8b-f22a-42b5-846d-8314c08dd793'),(3,NULL,'Content','textContent','matrixBlockType:39b7122f-8343-4bfd-ba42-51db49838e4a','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":\"1\",\"columnType\":\"text\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\"}','2016-06-24 20:30:35','2021-01-18 20:25:27','c5a9f115-5b57-497d-9a9f-c76ef6a8881e'),(4,NULL,'Quote','quote','matrixBlockType:67031931-0155-4204-8483-32624008ae23','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"redactorConfig\":\"\"}','2016-06-24 20:30:35','2021-01-18 20:25:23','1a3b8507-a4a7-472b-9b10-e99f057d5cd6'),(5,NULL,'Citation','citation','matrixBlockType:67031931-0155-4204-8483-32624008ae23','',1,'none',NULL,'craft\\fields\\PlainText','{\"charLimit\":\"\",\"columnType\":\"text\",\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2016-06-24 20:30:35','2021-01-18 20:25:27','b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c'),(6,NULL,'Image','image','matrixBlockType:67470af9-2f4e-4aac-b68c-d4c787c163e4','',1,'none',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"singleUploadLocationSource\":\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\",\"singleUploadLocationSubpath\":\"\",\"sources\":[\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\"],\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2016-06-24 20:30:35','2021-01-18 20:25:27','bc8a2715-5172-471b-8357-589ba0ab3209'),(7,NULL,'Caption','caption','matrixBlockType:67470af9-2f4e-4aac-b68c-d4c787c163e4','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2016-06-24 20:30:35','2021-01-18 20:25:24','1beade96-c14b-406a-896b-e052a13ec594'),(8,NULL,'Layout','layout','matrixBlockType:67470af9-2f4e-4aac-b68c-d4c787c163e4','',1,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Left\",\"value\":\"left\",\"default\":\"\"},{\"label\":\"Right\",\"value\":\"right\",\"default\":\"\"},{\"label\":\"Full\",\"value\":\"full\",\"default\":\"\"}]}','2016-06-24 20:30:35','2021-01-18 20:25:25','942db2b2-2993-4398-95a5-fa14532c58d0'),(9,1,'Link URL','linkUrl','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2016-06-24 21:20:19','2021-01-18 20:25:24','8cb1f015-2f0a-4758-89c3-fbb35b49a190'),(10,1,'Link Description','linkDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"redactorConfig\":\"Standard.json\"}','2016-06-24 21:20:54','2021-01-18 20:25:23','4a7f66f8-f0f6-47b7-89de-5eca5fc48600'),(11,2,'Episode Description','episodeDescription','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"redactorConfig\":\"\"}','2016-06-24 21:54:18','2021-01-18 20:25:23','1d0a4430-e8d9-49c3-b910-64c5008d3f3b'),(13,2,'Episode File','episodeFile','global','',1,'none',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"audio\"],\"defaultUploadLocationSource\":\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\",\"defaultUploadLocationSubpath\":\"{slug}\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add the MP3 file for this episode.\",\"singleUploadLocationSource\":\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\",\"singleUploadLocationSubpath\":\"\",\"sources\":[\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"],\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2016-06-25 01:55:41','2021-01-18 20:25:27','9491ba1e-9c32-45fe-a97f-b0d25dc40071'),(14,3,'Book ASIN','bookASIN','global','The ASIN from Amazon.com for this book. Your affiliate ID will be automatically included in the URL. ',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2016-06-28 22:43:58','2021-01-18 20:25:24','6f055d5e-e5e3-4363-81de-c7dff55ad3b3'),(15,1,'Teaser Copy','teaserCopy','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"redactorConfig\":\"Simple.json\"}','2016-06-29 03:04:24','2021-01-18 20:25:23','cf2dac30-56a5-4a12-91a4-ed35d2eed4ab'),(16,1,'Teaser Image','teaserImage','global','',1,'none',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add image to use in homepage/listing page teaser.\",\"singleUploadLocationSource\":\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\",\"singleUploadLocationSubpath\":\"\",\"sources\":[\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\"],\"useSingleFolder\":\"\",\"viewMode\":\"list\"}','2016-06-29 03:08:04','2021-01-18 20:25:27','736e7c2a-c6c7-4609-b1f2-38e7709e56cf');
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqlschemas`
--

LOCK TABLES `craft_gqlschemas` WRITE;
/*!40000 ALTER TABLE `craft_gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_gqlschemas` VALUES (1,'Public Schema','[]','2021-01-18 20:27:39','2021-01-18 20:27:39','831c6792-c373-4eaa-b38d-caa740ca83d2',1);
/*!40000 ALTER TABLE `craft_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqltokens`
--

LOCK TABLES `craft_gqltokens` WRITE;
/*!40000 ALTER TABLE `craft_gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_gqltokens` VALUES (1,'Public Token','__PUBLIC__',0,NULL,NULL,1,'2021-01-18 20:25:28','2021-01-18 20:27:39','59ea2480-fe92-4da5-9302-6b2fa40674a2');
/*!40000 ALTER TABLE `craft_gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_info` VALUES (1,'3.6.7','3.6.4',0,'rajhaxcllesd','yibjganznxjt','2016-06-24 17:18:47','2021-03-02 20:03:23','fe476427-1aed-40b7-adf8-38092200e499');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixblocks` VALUES (10,9,1,3,1,NULL,'2016-06-25 02:16:44','2016-06-29 03:28:18','353d6b9d-ef7b-4a87-a7d7-390b9220a288'),(11,9,1,1,2,NULL,'2016-06-25 02:16:44','2016-06-29 03:28:18','eda31a4f-d2c8-4d74-9a27-bfb71096a743'),(12,9,1,3,5,NULL,'2016-06-25 02:16:44','2016-06-29 03:28:18','27a4dd24-6781-4495-ac78-7ed2eb26f52b'),(13,9,1,1,7,NULL,'2016-06-25 02:17:08','2016-06-29 03:28:18','344f3995-4984-43d9-94ab-e7769fb5ebf8'),(15,9,1,3,3,NULL,'2016-06-25 02:22:42','2016-06-29 03:28:18','81ab1bce-2229-40ec-bb64-071414588547'),(16,9,1,2,6,NULL,'2016-06-26 00:40:56','2016-06-29 03:28:18','f52fd551-5113-4516-9be8-b1d63c071b18'),(17,9,1,1,4,NULL,'2016-06-26 00:44:58','2016-06-29 03:28:18','f4037475-83de-4568-93b3-307ecb29a664'),(19,18,1,3,1,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','2f54766c-9d52-4871-a38c-141bd10ce483'),(20,18,1,1,2,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','06284793-1e6f-4318-9a4a-7dc46fa4e3e2'),(21,18,1,2,3,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','7b964bc8-f435-4a93-8497-3b0ed075e8d9'),(28,27,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','510ccb41-baf7-462e-b912-fb6b342844fd'),(29,27,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','05173524-993a-4916-a9ee-f90fc8c0b0f5'),(30,27,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','33b7cfbd-2315-40d5-9521-0fa1574d0d4f'),(31,27,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','4c3be52a-187b-44ab-9f30-6af2933958b7'),(32,27,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c825bd81-44da-4973-8ebc-73b0f446b33c'),(33,27,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','5258232f-c9bf-4b62-95ab-f7fa39d94f76'),(34,27,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','e4c4fa6a-0f17-46cd-a585-dec63c1db392'),(36,35,1,3,1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','7621ca7a-44d0-4b26-8451-54e29510af22'),(37,35,1,1,2,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','865859e7-19cd-4c77-a9c7-dce470f8edb1'),(38,35,1,3,3,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','593d5d1d-2953-45e4-b065-350bf6a6c775'),(39,35,1,1,4,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','fefb0a62-94cf-425b-ad34-2a20af2d4425'),(40,35,1,3,5,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','3de8a680-b39e-4d1d-b928-bd6d12362153'),(41,35,1,2,6,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','316f7273-23de-45c2-8204-840cda8a1872'),(42,35,1,1,7,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','d54e0767-7466-4a00-b2a6-34105b14ab60'),(43,35,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','85bd9482-a264-4ed5-a597-574cc74624d0'),(44,35,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','8aecedce-c6aa-4a62-b434-33c316102c11'),(45,35,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','6ec5a00d-015f-45ac-98f6-246c39d8aa53'),(46,35,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','6d428426-ada3-4edd-b7d4-81b2e4a5e59e'),(47,35,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','1d4462e5-4bc0-4391-99a9-11fa44671b61'),(48,35,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c091913f-ea79-4a96-9f96-7aad8bf65d36'),(49,35,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','14f7c0b8-2ce9-41ec-b3b1-ea1e4f516739'),(51,50,1,3,1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','f647de94-08f0-49f3-99a1-b3ccabacf4e4'),(52,50,1,1,2,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','44c999c3-9a67-4df5-bee9-16035bc05d33'),(53,50,1,3,3,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','125214c9-d0d6-4ab7-940f-1a290e4888d4'),(54,50,1,1,4,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','e6f665f5-b40f-4d02-a44a-3a628ac7dab4'),(55,50,1,3,5,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','a0a4de3c-500c-45b0-9e9e-1d161c1a4c30'),(56,50,1,2,6,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','7509790f-527b-402d-9c08-62553b7e75c8'),(57,50,1,1,7,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','eabf05d5-c858-4ab7-a70d-fbdbb5ffeee8'),(58,50,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','a7ecc5d3-4455-423e-88f5-857c219649f9'),(59,50,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','ace9a53b-fc95-41a7-8a94-d168732a6496'),(60,50,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','1e863614-cc29-47fd-8fd4-e45412ed9994'),(61,50,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','24b75e42-ae18-44ef-8465-2dd34a573035'),(62,50,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','1b92dcdd-6f47-4514-baf7-9c91b28e12fe'),(63,50,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','56ffb74d-76e8-45dd-948a-47ba34c13703'),(64,50,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','92487d99-d41c-43c6-b44f-b305a0458682'),(66,65,1,3,1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','7207ab28-17e6-4443-85c7-4997080e4c1b'),(67,65,1,1,2,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','808c6013-e6a5-4ec0-b46c-1cb2a164f585'),(68,65,1,3,3,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','dfe91f8c-a845-43ec-b32a-15e6bf59d80e'),(69,65,1,1,4,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','f14f3263-c2ad-4177-b26f-fdceede110c2'),(70,65,1,3,5,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','0c985fa8-9d70-4d62-99cf-3f56d16e4012'),(71,65,1,2,6,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','452c8ba6-2513-476f-adbc-9db89fd8d685'),(72,65,1,1,7,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','a7c7fda5-5d93-486e-a5be-4f9cda0d027c'),(73,65,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c0c2e090-4711-4b4f-a2a7-b8ff144ac400'),(74,65,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','37fed07c-70c7-434e-b611-e8a62c673ffe'),(75,65,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','7101837c-a8c6-447b-ab35-7177c588361b'),(76,65,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c31c973e-289a-4355-812d-fc176655d138'),(77,65,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','a0c34075-5029-453f-ba28-fb15ccf0c6a7'),(78,65,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','b1e53034-4ddf-4746-9075-22855b8a5d52'),(79,65,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','6e4cece8-879d-46a2-82fb-0139809f1803'),(81,80,1,3,1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','e394db9e-4dd7-4aa1-ba77-0a6f70b2c6b0'),(82,80,1,1,2,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','0e4f1fb0-9cea-49d7-9efd-3851890abbf9'),(83,80,1,3,3,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','7f2a76ec-be96-4502-a05c-26f56117ca9f'),(84,80,1,1,4,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','d8d789ca-4a8d-4828-9ba1-141fd83c2195'),(85,80,1,3,5,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','90bfd88d-dba2-4abc-b717-2144b315d6a5'),(86,80,1,2,6,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','e399a075-c0a6-4dde-8210-1da2ca1a16dd'),(87,80,1,1,7,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','44f8bff9-492e-47ee-8062-362bef57ff57'),(88,80,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','73a9ffb6-a6fa-4457-8f9f-019e39829504'),(89,80,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','e5c6e443-7e2f-457e-9fd7-38c373050d1a'),(90,80,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','d41d4eed-69a1-475f-9cae-5f4b84d0c077'),(91,80,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','731c988b-72cb-4c64-89be-6aea6f10dc52'),(92,80,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','59cb0530-d7c1-44b8-9bb6-a6b6a64e37ba'),(93,80,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','fcf1f3ea-4f4a-431d-a8a6-5dc4c6df31d6'),(94,80,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','86f34b68-268b-4859-9ab7-199546b4c816'),(99,98,1,3,1,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','53e1d455-3203-402f-a245-ad0f268dd842'),(100,98,1,1,2,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','65524d19-25dc-4b5d-a109-01cb0b383c50'),(101,98,1,3,3,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','21ad9da4-b783-4c3f-95ae-a8a966a2c237'),(102,98,1,1,4,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','51732c24-24d5-4466-836d-1c8aa5c89d61'),(103,98,1,3,5,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','623374e3-671e-4d1b-987a-0f9a921a16bd'),(104,98,1,2,6,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','3ba82d9d-2667-4d77-a22b-4c2d9189a5a2'),(105,98,1,1,7,0,'2021-01-18 20:27:23','2021-01-18 20:27:23','584ba66e-8eac-40e3-ad79-58879a48da8f'),(106,98,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','bba4b88f-b222-4463-a134-97d52f657c3a'),(107,98,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','b2b8e0de-bc12-4927-ab13-4364b45b8038'),(108,98,1,3,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','9c800e12-05e4-4b2c-8ef2-3b08b8d6fca7'),(109,98,1,1,4,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','11392362-9d5a-45d5-8661-874b63891342'),(110,98,1,3,5,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','396775ad-6af3-445f-9e97-50fe9a05ecd0'),(111,98,1,2,6,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','cd405e65-715e-4f8f-a227-31079b42c0fa'),(112,98,1,1,7,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','3dd5ae72-03c8-4d45-8561-2041e5b2a71e'),(114,113,1,3,1,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','0e8771f0-ab4f-41fd-9ca2-d6519cb0cce8'),(115,113,1,1,2,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','c615235f-f2b1-4b94-aa93-127210facc4d'),(116,113,1,2,3,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','89c33678-7af4-4546-b494-a8b0d43c1ff6'),(118,117,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','84fa7e86-8fe6-4af6-a8d2-ef75dae82ec2'),(119,117,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','21415cd5-dedb-4a40-8470-cf385aae646e'),(120,117,1,2,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','946ab910-b9fa-40d3-8952-f2936ab26a5d'),(122,121,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','229917fa-ba46-40e6-866c-82fedf664bc9'),(123,121,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','58cbe2c8-c989-40a9-98de-0c6900c1f7bd'),(124,121,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','99c2074e-0a5a-43c0-832a-2f72c626c587'),(125,121,1,1,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','b3421c36-b100-439e-ae74-eb3ad45aefd7'),(126,121,1,3,5,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','6b2c9d2b-5ded-461f-90c5-c6fc372ef558'),(127,121,1,2,6,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','9ba4167d-4e61-401c-8cbb-478486273abf'),(128,121,1,1,7,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','8146316c-af17-4573-bea3-956b5b22be13'),(129,121,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','6da8762f-3906-42e3-84f4-0b38b2bf9f2c'),(130,121,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','77107e8a-5dd9-45d3-bdc9-9e66e46a0531'),(131,121,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','db989cde-4328-4cce-b7da-57423d4d2451'),(132,121,1,1,4,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d02a9e5a-1fb4-4a93-bcc1-3c660fce9e89'),(133,121,1,3,5,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','b9d2d304-aa8c-4f05-bac4-685b0e0fa579'),(134,121,1,2,6,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','9a0572c2-6664-4a5f-9d92-ff1aaa60ea12'),(135,121,1,1,7,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','e939a1a6-182f-4150-8bd2-f408c9e8e52e'),(137,136,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','bb03fe5f-4e03-464f-bf61-5b5692e63768'),(138,136,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','3af315ce-aa3f-464a-ae7e-819d806fadca'),(139,136,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','4c9b5097-8f5c-4be8-9faa-a5c43a3a42b1'),(140,136,1,1,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','bbd546c7-443c-4a60-b9b5-91bb283162d0'),(141,136,1,3,5,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2c3623a0-c05b-4768-b98e-eb7a139c96ef'),(142,136,1,2,6,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','91cb5876-9a8f-40a3-8523-cd80f9a9a16f'),(143,136,1,1,7,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','c598801a-549b-4149-8ff6-85502af65fb0'),(144,136,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','b9803eb7-ee3a-4d36-93e1-1dfa42e55d27'),(145,136,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','096a826f-b3b3-4728-80ae-2280a1b38101'),(146,136,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','f3a42ac7-9d81-4806-bd1d-53e93c5ded5e'),(147,136,1,3,4,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','1b5786b3-a181-41b1-9581-74e37af32979'),(148,136,1,2,5,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','23b0f70d-67e5-45b8-835a-31e19068de5c'),(149,136,1,1,6,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','45beaa53-ad47-41fa-be7c-cf10b06b99fb'),(151,150,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','9c8df691-edea-4027-aa8c-2240520c5d45'),(152,150,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','1ca22002-dca8-4c10-8d6f-e476be818a53'),(153,150,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','e3f27990-a514-4d4d-adc8-be2e3b0785df'),(154,150,1,3,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','6117789c-0997-4f7d-a576-ef043f77133b'),(155,150,1,2,5,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','e0aac9e6-e5b0-491d-827b-835c82178654'),(156,150,1,1,6,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','2f032fec-c8ad-4cf2-b92d-2c6d12dcba5a'),(157,150,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','93274dec-9b9b-479b-bd19-67f1a935249e'),(158,150,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','19db93ab-e553-46e2-b15e-2a68f880eb41'),(159,150,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','aeae9ab1-e09d-445b-89f7-324de868e8fb'),(160,150,1,3,4,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','a8171357-0ca9-48de-851e-90fa179c7038'),(161,150,1,2,5,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','36da3c4b-3f46-48aa-9e3c-97f970078e46'),(162,150,1,1,6,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','c79a38a5-2dc5-452a-8186-a31939c5214f'),(164,163,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','dd4871f4-4467-42d1-a676-30661fb71175'),(165,163,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','238f4ca8-1b66-44c7-85d4-303100421ebd'),(166,163,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','30e4d670-04cc-45c0-a0aa-f86e12dce622'),(167,163,1,3,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','fa7eb205-5efb-49f4-b7ae-79728fe3bbcf'),(168,163,1,2,5,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','aba7a3b5-8f85-49b6-b7d5-ac6d4653e3db'),(169,163,1,1,6,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','15f46e04-7167-464a-8114-b564b0b8af67'),(170,163,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','9eaf776b-0520-4361-83ce-616826750792'),(171,163,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','2a6643a9-877f-40aa-a2e0-eac4e910388d'),(172,163,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3bd2ebf5-aeb7-4e33-a7ca-c17551021b3a'),(173,163,1,3,4,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','04daab49-d756-4946-98d9-8480a0f51790'),(174,163,1,1,5,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','8157bed5-0cad-474b-91d5-876df4e7e73f'),(176,175,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','9fe7efde-3c97-4d89-bda7-9c1f87c1c7c9'),(177,175,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','6ed55bd8-1652-45be-8ad4-2d1b54b90e8b'),(178,175,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','b12be8b6-ad04-4168-8a8a-2d0717c45c3d'),(179,175,1,3,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','8db6476a-1be1-4b0f-bc2a-ea5f37804455'),(180,175,1,1,5,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','9e50d30d-e7bd-4414-9254-ade02575ea15'),(181,175,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','e9a9bc49-f571-4e97-ad32-f8df0174687b'),(182,175,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','7afa7344-a183-4638-848a-852a66832e2a'),(183,175,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d6577c1f-d12d-4e63-b420-3c687a916217'),(184,175,1,1,4,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','9c9f12c0-252f-4306-97f7-908c9f2912b1'),(186,185,1,3,1,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','0db23499-6367-46a6-a21f-11d8b963fc1b'),(187,185,1,1,2,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','76c4c3bb-0da9-4497-a49e-71ca7732f5a3'),(188,185,1,3,3,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','9697b870-1766-4036-a735-851310e4eb5b'),(189,185,1,1,4,0,'2021-01-18 20:27:24','2021-01-18 20:27:24','da0ec0b6-87f4-4b03-b66d-a7f322801d65'),(190,185,1,3,1,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','cd8a4663-5654-4ad8-b2cd-d884c3ddbce9'),(191,185,1,1,2,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d1fab29d-8f5a-42f2-b751-db866daf5147'),(192,185,1,3,3,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','dafbeb03-1fd0-4412-9c2d-41a2760f626a'),(203,202,1,3,1,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','92ea8269-7691-4c04-a3f2-35724bea13f0'),(204,202,1,1,2,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','ed389b7e-6df3-4571-ac74-d7836d867a1b'),(205,202,1,3,3,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','cff1a09c-98db-4bc8-b99e-6e9b5e4373e9'),(206,202,1,1,4,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','e1ddc8fc-0745-4542-956d-ec4abf661860'),(207,202,1,3,5,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','3db822e8-0f05-4623-9271-591f120e97cd'),(208,202,1,2,6,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','9c487787-53e5-4d7d-b840-743a0627cec5'),(209,202,1,1,7,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','0bbf9922-7027-4217-b7b4-0b9c3e308603');
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixblocktypes` VALUES (1,1,23,'Text','text',1,'2016-06-24 20:30:35','2016-06-25 02:15:06','39b7122f-8343-4bfd-ba42-51db49838e4a'),(2,1,24,'Blockquote','blockquote',2,'2016-06-24 20:30:35','2016-06-25 02:15:06','67031931-0155-4204-8483-32624008ae23'),(3,1,25,'Image','image',3,'2016-06-24 20:30:35','2016-06-25 02:15:07','67470af9-2f4e-4aac-b68c-d4c787c163e4');
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixcontent_body`
--

LOCK TABLES `craft_matrixcontent_body` WRITE;
/*!40000 ALTER TABLE `craft_matrixcontent_body` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_matrixcontent_body` VALUES (1,10,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2016-06-25 02:16:44','2021-01-18 20:51:49','9a382ac6-a62f-46d5-a6bf-0f96046d5d00'),(2,11,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2016-06-25 02:16:44','2016-06-29 03:28:18','bc28bd2e-6a37-46ed-b775-7bf6124f1bb2'),(3,12,1,NULL,NULL,NULL,'','left','2016-06-25 02:16:44','2021-01-18 20:51:49','fe6a14df-cfd5-472f-8bac-cd9c7c7feb17'),(4,13,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>',NULL,NULL,NULL,NULL,'2016-06-25 02:17:08','2016-06-29 03:28:18','ea13e85a-7c7a-4767-83a0-757b26f06f36'),(5,15,1,NULL,NULL,NULL,'','full','2016-06-25 02:22:42','2021-01-18 20:51:49','e3e39cfb-7cf2-4fb0-8dcf-7dff1a27b271'),(6,16,1,NULL,'<p>This is the quote from Bob Dole. Hi I\'m Bob Dole.</p>','Bob Dole',NULL,NULL,'2016-06-26 00:40:56','2016-06-29 03:28:18','fa4c3df6-38e4-4865-994d-8c0205ad0b0e'),(7,17,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.</p>',NULL,NULL,NULL,NULL,'2016-06-26 00:44:58','2016-06-29 03:28:18','ab3e4b23-5d07-4e0b-bd98-b75f7bf6eda8'),(8,19,1,NULL,NULL,NULL,'Pioneer Missions Poster, NASA Flickr Commons','left','2016-06-27 19:21:57','2016-06-28 22:51:09','53d1ac4f-33ef-479c-8086-1ad1a82ca385'),(9,20,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>\n\n\n\n<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','1ce19a8c-406c-4319-b786-91cf4fcd99d5'),(10,21,1,NULL,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>','Ryan Irelan, Mijingo',NULL,NULL,'2016-06-27 19:21:57','2016-06-28 22:51:09','8ff7401c-f50f-4628-b522-690701582514'),(11,28,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','83230314-1144-477d-9f18-1ca6666fcb05'),(12,29,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','086bee9e-316d-4218-a240-d7974771e15d'),(13,30,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','c88ef741-15b2-4b9c-8367-47d928de6d3f'),(14,31,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','b2760965-0ade-4752-adbc-aaae5a57e5b8'),(15,32,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','29a1dba4-0630-4448-b64c-ad6c5d12aca4'),(16,33,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','73d17e23-abe2-42dc-bbb1-ff05e5fc0777'),(17,34,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','7e377006-7e8e-4e81-ac7c-d5dac8c0d09c'),(18,36,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','a1d5cb15-9721-439c-8c48-dd1238deb414'),(19,37,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','8c90d47f-355b-473f-a6c7-ab7af3c9e4b2'),(20,38,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','dbf39ba5-c410-420f-b26c-1daf21578774'),(21,39,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','b4687800-9d71-4386-90f4-32c21234f634'),(22,40,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','6ba1802a-ed49-4cc4-9b5a-2e5d66b55d99'),(23,41,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','48d3e028-4565-453e-af8c-f815feb21536'),(24,42,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','f9b4073a-f587-486d-94c0-d9622a52da76'),(25,43,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','81dfe6f8-47c2-432f-9c6f-86119077048d'),(26,44,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','18556960-9821-4b1f-a0b1-2bf6124fccff'),(27,45,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','c3c89d7b-8e14-45bf-b39c-400fd77ae775'),(28,46,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','7776157f-dde4-4461-87fe-2e6db56df990'),(29,47,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','28300e26-78c5-4803-aeb4-e8d2896c6546'),(30,48,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','a5a8869c-8b41-4451-bc04-94fe0340a0cc'),(31,49,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','d32b9853-fd8c-44a0-9e33-4099c28829c7'),(32,51,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','05f02a8c-b894-48c3-998d-261118bd5e28'),(33,52,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','de1ab157-807a-4e62-b41e-d58c5f2229b0'),(34,53,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','c12d2954-a6c7-4b1d-b0c5-9cee101ae744'),(35,54,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','bcdaed94-26a9-4acc-8b5d-4f5bb0902a0b'),(36,55,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','0dce9aa5-5e2a-49f4-af72-0c8f002c27ba'),(37,56,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','09807798-4c74-4cc0-a165-b2146a8b71a9'),(38,57,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','ce0a6f3a-544f-43ab-a5f1-0c7ae5e75630'),(39,58,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','d60914a1-6292-416b-8fab-4f82547c031e'),(40,59,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','cd84ecc3-70f8-476a-be55-4cdf1631c61f'),(41,60,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','482f7202-fea7-4150-a1d3-3591399247fc'),(42,61,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','32cfc4ec-5087-41a7-bfa1-535cd169374e'),(43,62,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','38ccbc08-e79b-48aa-ba15-a37e03c809d8'),(44,63,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','5457aa00-8112-4800-8bb0-8fc111670990'),(45,64,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','f45dff2f-5819-4b7e-b84d-0502e9a00086'),(46,66,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','cf45e3ee-6c1d-4c22-bdd6-810f2c46d7cf'),(47,67,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','49c007d6-1e7e-453a-8dbf-ac6d81d9ed2a'),(48,68,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','00d09ba1-5249-41a2-bda8-71cee745a3df'),(49,69,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','b786beac-bec5-4a88-9141-70fe2a6f52ff'),(50,70,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','6e1d86be-f984-4bf8-856e-8d889d1d7016'),(51,71,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','42f520f1-e1e4-415e-a773-1f2ca0d3664a'),(52,72,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','35b08e70-9e77-4b3f-a1cf-b2c30df7bb64'),(53,73,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','7cc69545-78d3-444a-97a6-a6acff5b98f4'),(54,74,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','8290e468-c3c1-4fd9-86f0-92d913d76793'),(55,75,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','9388c3dd-8233-40c0-b0c0-feadacf74271'),(56,76,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','bcdcdf7c-b023-48c2-a96b-dfa180f7d566'),(57,77,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','6ec0157a-b536-4f8b-bfab-6796b2e9252c'),(58,78,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','95773607-4704-490b-a6d8-991ce925861a'),(59,79,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','3539118a-dad0-4702-b182-07b666ae64f3'),(60,81,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','7a78e6dd-2019-4251-ac90-a2396742f6e5'),(61,82,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','9ec385d1-f4fc-4ea7-a9e0-0275302b1849'),(62,83,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','3d8ee14d-0687-446d-b453-425f43e6b5c3'),(63,84,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','87e9c71c-f4a7-4ef9-9500-3aefcf94221a'),(64,85,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','5f6b3552-8011-4f60-ba75-14dc6de28f50'),(65,86,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','44536637-eb9d-4970-8b56-7519fb8f5d8c'),(66,87,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','4ddfd0b9-e94d-4920-95b1-537533972f1a'),(67,88,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','8630fc15-438b-472c-b775-6c28227699e5'),(68,89,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','1266ef09-32b3-44b5-a571-2064dfc5facd'),(69,90,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','0cf75387-b201-4a21-87d4-39d7ce63d068'),(70,91,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','49c437eb-3335-4c67-81d7-a445fe2692fe'),(71,92,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','6d246b4b-9514-4d33-b0aa-882038229858'),(72,93,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','63c989e3-5286-4736-af57-e212c386c041'),(73,94,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','190c23f5-c416-45fc-8965-17f9146361d0'),(74,99,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','f76c049f-a9ee-4e3d-b027-d1f247440c66'),(75,100,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','f764bfc4-b5a8-47c9-90a9-64bdf1b0ad76'),(76,101,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','af44eb5b-1678-4cce-88d9-4ea003debe2b'),(77,102,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','7266afd6-838d-48cb-881e-175be9fb087e'),(78,103,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','ec9093b3-726b-45b1-9237-00e6e0287b95'),(79,104,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','cc055c6a-74b5-48aa-a570-bf00f41fbf20'),(80,105,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','e4cbd1da-9e54-44e8-8da9-8a2490b22522'),(81,106,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:23','2021-01-18 20:27:23','b13dec92-d117-4d5b-8eca-007d72e2aa26'),(82,107,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','4d6288fe-c12f-41fc-918e-3c9ef2fb02ce'),(83,108,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:23','2021-01-18 20:27:23','73e53be1-c2dc-4594-98dd-7b8bdce2c488'),(84,109,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','f6dbffb9-0fa9-444c-ae80-a03c13fc60cb'),(85,110,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:23','2021-01-18 20:27:23','64c24bab-6698-400f-bcb1-2a5ca87981fb'),(86,111,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','332101a5-179a-4ea8-8b9d-ea5b2ce71b8c'),(87,112,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:23','19ee0016-960d-49fa-bb5e-20edaf9a69e9'),(88,114,1,NULL,NULL,NULL,'Pioneer Missions Poster, NASA Flickr Commons','left','2021-01-18 20:27:23','2021-01-18 20:27:23','a2bf97f4-75d5-4092-b163-12d9792301e7'),(89,115,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:24','ba336db8-f75d-4a36-a8c8-4e4354304e58'),(90,116,1,NULL,NULL,'Ryan Irelan, Mijingo',NULL,NULL,'2021-01-18 20:27:23','2021-01-18 20:27:24','f485c52b-d270-4338-862e-ce676519fbc6'),(91,118,1,NULL,NULL,NULL,'Pioneer Missions Poster, NASA Flickr Commons','left','2021-01-18 20:27:24','2021-01-18 20:27:24','76ca77d9-1258-4122-935f-6c57698f2e6e'),(92,119,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','06964a59-d083-427a-8cdd-872f45aad4f4'),(93,120,1,NULL,NULL,'Ryan Irelan, Mijingo',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','afe14e19-1154-4df0-a3b7-a0b40c017a67'),(94,122,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','7d56cf46-90a0-448f-a42e-f034550d47a1'),(95,123,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d92f373d-ab33-4ef7-b8f7-b0a79914082c'),(96,124,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','29cddc7e-bfad-4df5-948b-fa3718ba34f6'),(97,125,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','f697b8a7-d38c-4a27-a8f8-08feb9d39e40'),(98,126,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','f89181c6-0652-4972-ab2d-437c758fef1b'),(99,127,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','1448531d-789b-42f9-b07e-be5dcd5614db'),(100,128,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','0f946f24-9fda-4ea7-b1b0-8129e2563fca'),(101,129,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','2e8d9c84-23c1-49cb-b8cf-08509aa0d7ca'),(102,130,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3e18161c-d8d0-46eb-8c7f-48f40d0d3181'),(103,131,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','105f3869-290f-49d6-962e-b0fbc895e58c'),(104,132,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d6b3d391-b981-4f93-8253-f6b76cbd0d2e'),(105,133,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','deaf4d41-5729-4f8e-a9b7-3425746500f2'),(106,134,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','8f80c7ea-d8df-4b7b-86ed-5fc1178cc6ef'),(107,135,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d3622ad1-5d35-4981-bc31-f33f4a88a198'),(108,137,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','af5b9508-5c81-4958-b03e-be314513cf49'),(109,138,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','6c5ee5d5-428e-4600-a962-1d93e5e1823e'),(110,139,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','252f093b-a0d1-4556-9833-eac3c2696ef6'),(111,140,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','14146d17-fefa-465d-b2ca-5876cf937bd2'),(112,141,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','afe90274-5b86-48fd-bdf7-97515291c84c'),(113,142,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','7b38339a-ae6d-451c-aff3-55f8c9b2c642'),(114,143,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','80f97884-69e2-42b6-bad0-6f30557498d7'),(115,144,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','e529d86e-b2ef-4b09-a345-67907614bd22'),(116,145,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','46b3ae67-2254-4304-b6bf-7ba5e53a8b55'),(117,146,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','fafa1979-18dd-4387-836c-5c55241ef2d2'),(118,147,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','c43f0a1f-04b3-4151-8e62-3e09a52a92fb'),(119,148,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','ce2ce45f-3770-4196-82bd-a383dde249a1'),(120,149,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','b13194fe-4201-475c-aeb3-09cf1d6e3b89'),(121,151,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','56630959-8236-47f6-9052-a28b62636268'),(122,152,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','837b3105-b494-4d55-ac03-f7b547199e0d'),(123,153,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','574c617e-1bc9-47af-a0f1-c4e5e35575bb'),(124,154,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','51ca6c35-e9f0-4954-9efc-64124b49d505'),(125,155,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','89590a43-fe5b-4cd5-8a38-e9a624ccf49f'),(126,156,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','89b15011-bc2f-4ba6-ad13-60e6f9e28123'),(127,157,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','b7594ebd-8249-41ba-84a9-c38d4dfa2d96'),(128,158,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','06d0111f-dd25-4ecd-abce-e6de4e6de4ab'),(129,159,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','3e5283e7-b862-4673-91de-758391e4adc5'),(130,160,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','a0ea672f-7bc5-4491-98fe-ad11b44afbc8'),(131,161,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','1f1ba2c6-5515-407b-a98d-c64b62e4dbfc'),(132,162,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','b3622f45-d59d-413a-9ade-e6e7a52f9ca3'),(133,164,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','7aa029f6-9b3b-481c-ae87-8fdc34957b41'),(134,165,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','a91e1b10-4fae-4b57-9a59-a4342df66264'),(135,166,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','279279ad-278f-4eae-be40-e274e527ea68'),(136,167,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','1e173a30-8f3a-4414-b426-a6911f332ac3'),(137,168,1,NULL,NULL,'Bob Dole',NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','56bc7d23-4232-436f-b700-9c9ab4f5fdad'),(138,169,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','f66aec35-9a58-40d8-9095-7590c2fe7ff4'),(139,170,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','e61bfb12-c985-497c-8669-7aa9fe65276a'),(140,171,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','e8f3f3a8-e6f3-4ff2-a4b2-e94f6c5a2262'),(141,172,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','5b3ef664-d7dc-41a3-8678-d6073c43a90a'),(142,173,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','cfac11d0-b163-4e1d-9b78-705e14d6aeb8'),(143,174,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3fadaacd-37ce-4362-8b8a-178a5f4b9d3c'),(144,176,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','94ba34f3-8989-4adc-8087-c58d46b6a6c6'),(145,177,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','51629687-181b-426f-951b-1065ae472f61'),(146,178,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:27:24','2021-01-18 20:27:24','44f5a05f-16ce-497e-afc0-5833a80fc324'),(147,179,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','b40f8df5-b49f-4606-aaf0-d2e6cfabdcf5'),(148,180,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','dcdba9ce-965e-4a66-9716-b32dcecb6ee3'),(149,181,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','c6739066-dfd8-4d45-89cf-f0fa66e3f57e'),(150,182,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','9a0e5899-4ccf-4520-b6ae-6d5c63eef6ae'),(151,183,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','2580f1db-bce9-48ec-b197-d593ff242ce0'),(152,184,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','3bc9950f-d333-4bff-a27f-ad410503c1a3'),(153,186,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','52f97361-25a0-42eb-8d4c-6347aaff2cc1'),(154,187,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','74a9cf2e-2f11-4373-8b41-b63d286975a1'),(155,188,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','9edb1adb-5e5b-4ff7-a4a4-d08f5737cac6'),(156,189,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','aab87798-18a0-48bf-b885-06a44ff85ea7'),(157,190,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:27:24','2021-01-18 20:27:24','9f107dc8-af6a-4c1b-91f6-eba132a165fe'),(158,191,1,NULL,NULL,NULL,NULL,NULL,'2021-01-18 20:27:24','2021-01-18 20:27:24','d78ca12b-eca8-4a6f-86e3-05de3ac7cc97'),(159,192,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:27:24','2021-01-18 20:27:24','21a23c87-5d74-4a8a-bca6-b5c9709f31d3'),(160,203,1,NULL,NULL,NULL,'1983 Photo of Pioneer 10 - NASA via Flickr Commons','full','2021-01-18 20:51:49','2021-01-18 20:51:49','7300cbdd-5ec3-4b96-9733-f6d98e45a92e'),(161,204,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>',NULL,NULL,NULL,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','e721ab0f-0412-4f70-8af9-2ee8fc497473'),(162,205,1,NULL,NULL,NULL,NULL,'full','2021-01-18 20:51:49','2021-01-18 20:51:49','f401ee55-bfea-484c-a319-ea97e0dcd9c5'),(163,206,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.</p>',NULL,NULL,NULL,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','cf8847ae-c870-4ee6-8e99-b175a61397bf'),(164,207,1,NULL,NULL,NULL,NULL,'left','2021-01-18 20:51:49','2021-01-18 20:51:49','5100c044-5e5a-4567-9ef1-d342aab81081'),(165,208,1,NULL,'<p>This is the quote from Bob Dole. Hi I\'m Bob Dole.</p>','Bob Dole',NULL,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','b3d89f7b-a3b2-45e3-85c1-43ca2935ab0a'),(166,209,1,'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\n\n<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?</p>',NULL,NULL,NULL,NULL,'2021-01-18 20:51:49','2021-01-18 20:51:49','a7cab602-4163-4404-8463-021579ca62e5');
/*!40000 ALTER TABLE `craft_matrixcontent_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_migrations` VALUES (1,'craft','m000000_000000_base','2016-06-24 17:18:47','2016-06-24 17:18:47','2016-06-24 17:18:47','312459d6-a72c-4155-a74f-85dea8372786'),(2,'craft','m140730_000001_add_filename_and_format_to_transformindex','2016-06-24 17:18:47','2016-06-24 17:18:47','2016-06-24 17:18:47','0124b98c-eecb-4d92-9e80-8bfe78e83155'),(3,'craft','m140815_000001_add_format_to_transforms','2016-06-24 17:18:47','2016-06-24 17:18:47','2016-06-24 17:18:47','23bed499-346c-4def-877a-de031ad3aa34'),(4,'craft','m140822_000001_allow_more_than_128_items_per_field','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','888121fd-c3f7-409d-a184-aa8f1833872e'),(5,'craft','m140829_000001_single_title_formats','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','d73cb8f5-734e-4b84-befb-c30a06e348a4'),(6,'craft','m140831_000001_extended_cache_keys','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','ed0a651c-669e-4510-b2de-f4972e1c000d'),(7,'craft','m140922_000001_delete_orphaned_matrix_blocks','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','6e6d90a7-1d4e-4f85-adb9-90e82561bb3d'),(8,'craft','m141008_000001_elements_index_tune','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','405ce803-f954-4497-807f-3d331a3c02ad'),(9,'craft','m141009_000001_assets_source_handle','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','aebff061-526f-4aa0-8bc5-cf3536bf228e'),(10,'craft','m141024_000001_field_layout_tabs','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','14326c2a-f1a7-442a-b794-369ed82845dd'),(11,'craft','m141030_000000_plugin_schema_versions','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','843b8cb6-54b6-4f7c-8a49-fff65bcc5596'),(12,'craft','m141030_000001_drop_structure_move_permission','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','40c4449a-8778-4997-9ea5-44601185f794'),(13,'craft','m141103_000001_tag_titles','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','5bde872d-991c-4b93-9a17-6d51048b1bac'),(14,'craft','m141109_000001_user_status_shuffle','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','cdd69c6c-ee34-43f1-a0ac-b854c19e24e5'),(15,'craft','m141126_000001_user_week_start_day','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','e356b6b7-0999-458c-927b-d535ee2c9095'),(16,'craft','m150210_000001_adjust_user_photo_size','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','8c081401-6ca7-44d0-b2bc-893e02ca005c'),(17,'craft','m150724_000001_adjust_quality_settings','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','7a6d78ee-f058-4228-a13a-f0d0d617ff5d'),(18,'craft','m150827_000000_element_index_settings','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','85323102-e1c6-4401-9f26-60ef0782d91b'),(19,'craft','m150918_000001_add_colspan_to_widgets','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','ac7f6fb5-7f60-4743-bd3b-41aa49f9b66f'),(20,'craft','m151007_000000_clear_asset_caches','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','9980ae9d-86cc-4add-b102-49ee8591ecf3'),(21,'craft','m151109_000000_text_url_formats','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','b6271286-8421-440c-a9d2-be753470f886'),(22,'craft','m151110_000000_move_logo','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','ed7bb774-c2f5-4b71-a845-e45ed4378cb5'),(23,'craft','m151117_000000_adjust_image_widthheight','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','0025e3b3-1bd2-4bc7-9446-141d4ddfb78b'),(24,'craft','m151127_000000_clear_license_key_status','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','68857aed-8ec1-4cfd-b883-b000eddb05ce'),(25,'craft','m151127_000000_plugin_license_keys','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','6ac0260c-31ee-4a68-80b0-8c84a5d4708f'),(26,'craft','m151130_000000_update_pt_widget_feeds','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','bcf87cc4-4d97-4ee4-95c3-75af9b2137bf'),(27,'craft','m160114_000000_asset_sources_public_url_default_true','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','566dfbed-1c4f-4636-ad42-ebb10ecae65a'),(28,'craft','m160223_000000_sortorder_to_smallint','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','f928c078-cd35-400b-9370-0c3e769c69f7'),(29,'craft','m160229_000000_set_default_entry_statuses','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','ed34a35c-2f5d-4916-93af-b6ce35d479da'),(30,'craft','m160304_000000_client_permissions','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','6369d520-5457-40cd-b275-6126529a301f'),(31,'craft','m160322_000000_asset_filesize','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','36db9b7e-fb47-42ea-ad61-92d1db316f6e'),(32,'craft','m160503_000000_orphaned_fieldlayouts','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','31d9c41c-60e7-48d3-913b-24138197b239'),(33,'craft','m160510_000000_tasksettings','2016-06-24 17:18:47','2016-06-24 17:18:48','2016-06-24 17:18:48','f9168808-78c3-4c3b-9026-05c41089fe9f'),(46,'craft','m150403_183908_migrations_table_changes','2021-01-18 20:25:21','2021-01-18 20:25:21','2021-01-18 20:25:21','95ff7c10-f3cb-40ef-bb08-aa2dba3db9c8'),(47,'craft','m150403_184247_plugins_table_changes','2021-01-18 20:25:21','2021-01-18 20:25:21','2021-01-18 20:25:21','b535ebaa-1e55-465c-922f-72eb66c4d6e7'),(48,'craft','m150403_184533_field_version','2021-01-18 20:25:21','2021-01-18 20:25:21','2021-01-18 20:25:21','3b7855d7-b511-4eb2-b8c3-d6a76d558e30'),(49,'craft','m150403_184729_type_columns','2021-01-18 20:25:21','2021-01-18 20:25:21','2021-01-18 20:25:21','a9bd2108-c453-436e-ab90-04177f29f99b'),(50,'craft','m150403_185142_volumes','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','9246fcf9-4100-4f58-b867-9fff88b44572'),(51,'craft','m150428_231346_userpreferences','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','d55b8a2b-131d-4c6d-8f94-72ba9e001d17'),(52,'craft','m150519_150900_fieldversion_conversion','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','12624394-2463-4872-959d-c4d3e707beda'),(53,'craft','m150617_213829_update_email_settings','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','fd5b560e-7f10-40ef-862a-62a8259efc30'),(54,'craft','m150721_124739_templatecachequeries','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','1772e356-d8a1-4678-861f-0fafb274efcc'),(55,'craft','m150724_140822_adjust_quality_settings','2021-01-18 20:25:22','2021-01-18 20:25:22','2021-01-18 20:25:22','d064dea4-846a-4ca7-a24e-da301444a441'),(56,'craft','m150815_133521_last_login_attempt_ip','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','7f3c56d3-b90f-41e9-ba3d-3fab8786d29a'),(57,'craft','m151002_095935_volume_cache_settings','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','33220e72-ae9c-4ac2-b869-caa765fe89aa'),(58,'craft','m151005_142750_volume_s3_storage_settings','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','a5c6e6c1-9429-4b84-9421-71eefef51c66'),(59,'craft','m151016_133600_delete_asset_thumbnails','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','9385ff09-75b2-4080-a4f8-54dddbbb894c'),(60,'craft','m151209_000000_move_logo','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','e008a9b2-e913-4fbb-aac4-f0b4fab72541'),(61,'craft','m151211_000000_rename_fileId_to_assetId','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','f78804fa-6a2f-44c4-acde-c95f6fcb2250'),(62,'craft','m151215_000000_rename_asset_permissions','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','ca05281c-187d-471a-b9d2-d0957f7eaf95'),(63,'craft','m160707_000001_rename_richtext_assetsource_setting','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','8474a318-9533-4e37-8f1d-82ba2a8427dd'),(64,'craft','m160708_185142_volume_hasUrls_setting','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','6b107929-ca25-4c74-b099-1f8b5b07e3c1'),(65,'craft','m160714_000000_increase_max_asset_filesize','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','61db52e0-d645-422e-b8ff-2b92e1f20119'),(66,'craft','m160727_194637_column_cleanup','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','866a0a3a-8342-4331-9d84-5de138526ae4'),(67,'craft','m160804_110002_userphotos_to_assets','2021-01-18 20:25:23','2021-01-18 20:25:23','2021-01-18 20:25:23','e4d94759-50e1-45a5-852d-7265db8db6ba'),(68,'craft','m160807_144858_sites','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','13e742c3-7312-4b3f-aa44-b7e6f5e5306d'),(69,'craft','m160829_000000_pending_user_content_cleanup','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','06a8651f-f2dc-460a-8e43-fd49ca955667'),(70,'craft','m160830_000000_asset_index_uri_increase','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','457a05de-0097-4905-a7ca-461efc0cd6ca'),(71,'craft','m160912_230520_require_entry_type_id','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','6a2c1c79-76b0-46bd-99c2-8dcdef6c96c0'),(72,'craft','m160913_134730_require_matrix_block_type_id','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','2f4c3810-1b6c-439a-8031-1df89700606b'),(73,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','24c64ad8-d5bb-4c59-93f1-2b471a057cd2'),(74,'craft','m160920_231045_usergroup_handle_title_unique','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','17526149-5e91-479b-9215-fbc6f7489cbc'),(75,'craft','m160925_113941_route_uri_parts','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','7b4a50de-471d-4d2e-b723-cd98c4555c7b'),(76,'craft','m161006_205918_schemaVersion_not_null','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','55b3f1c2-ec17-4f50-9541-2719e1a500bc'),(77,'craft','m161007_130653_update_email_settings','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','0e49711e-0e8e-470c-9652-422e7f84b135'),(78,'craft','m161013_175052_newParentId','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','9c14f910-84d8-4bff-9bba-f72cba168164'),(79,'craft','m161021_102916_fix_recent_entries_widgets','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','5a746a24-8533-4317-80e6-22ae2c12bc23'),(80,'craft','m161021_182140_rename_get_help_widget','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','e5398432-cd20-43a4-b2fc-48f1234307ec'),(81,'craft','m161025_000000_fix_char_columns','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','dd559afb-3903-40c7-8ccf-0a3885e1b341'),(82,'craft','m161029_124145_email_message_languages','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','c596e000-071f-4747-98bf-a05986b694c7'),(83,'craft','m161108_000000_new_version_format','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','2ee9d71d-dca3-4f2b-ac76-d4506eaf28e8'),(84,'craft','m161109_000000_index_shuffle','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','3c216331-8389-4d0f-8f8a-ac8df37836d0'),(85,'craft','m161122_185500_no_craft_app','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','e9b2d6f9-70f5-49b7-84b2-146c953d58ce'),(86,'craft','m161125_150752_clear_urlmanager_cache','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','05b560da-f1b7-4507-a735-53dc497567b7'),(87,'craft','m161220_000000_volumes_hasurl_notnull','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','133945ff-ff68-4d2e-87ff-d95223865d4c'),(88,'craft','m170114_161144_udates_permission','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','a2397664-fa4c-4d2d-ac28-ca6850f386e6'),(89,'craft','m170120_000000_schema_cleanup','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','734b6564-2383-4c8f-98d4-5c8427891ed8'),(90,'craft','m170126_000000_assets_focal_point','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','10ed1384-e490-4246-96a0-8542d8e89ed5'),(91,'craft','m170206_142126_system_name','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','1e827f06-7306-4de7-86a7-d2898e48e45d'),(92,'craft','m170217_044740_category_branch_limits','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','48bf2759-7dcf-442a-b9be-45a7aa7bcfc1'),(93,'craft','m170217_120224_asset_indexing_columns','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','16aaa2bd-8b31-4db3-b7dd-f5fe14354274'),(94,'craft','m170223_224012_plain_text_settings','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','af01e6a6-7cae-4b41-ae5a-298075d99886'),(95,'craft','m170227_120814_focal_point_percentage','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','f7f38559-c9dc-41ce-86ca-b05ce77b0042'),(96,'craft','m170228_171113_system_messages','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','e213adc8-7402-4c06-aa84-afc187624afe'),(97,'craft','m170303_140500_asset_field_source_settings','2021-01-18 20:25:24','2021-01-18 20:25:24','2021-01-18 20:25:24','dcac39a7-c4c3-486e-bf6e-7235772f0e94'),(98,'craft','m170306_150500_asset_temporary_uploads','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','92af44bd-d32c-45ba-ac4c-b26a01a302a9'),(99,'craft','m170523_190652_element_field_layout_ids','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','74807326-6540-4982-a1d4-8256b1e1c5de'),(100,'craft','m170621_195237_format_plugin_handles','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','a5245d8b-bc22-43b0-b724-a7ecf0a0450e'),(101,'craft','m170630_161027_deprecation_line_nullable','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','c49d19c9-617a-44a4-85fd-bdc12db0c015'),(102,'craft','m170630_161028_deprecation_changes','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','cde355b7-7d55-4df8-82fb-befcbfea7d08'),(103,'craft','m170703_181539_plugins_table_tweaks','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','b2994ffa-6cf3-430b-a377-83aec12e2d93'),(104,'craft','m170704_134916_sites_tables','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','e8615119-5312-49a7-a80a-86d5c9f74b6e'),(105,'craft','m170706_183216_rename_sequences','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','1b63b6e7-8d96-4f18-a098-83925f60727b'),(106,'craft','m170707_094758_delete_compiled_traits','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','f2a2ed38-dc2d-4ce6-bfb1-6bc5420ac728'),(107,'craft','m170731_190138_drop_asset_packagist','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','cb8dc6f2-903f-4024-b9f9-7111e4cf271d'),(108,'craft','m170810_201318_create_queue_table','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','02220886-ca56-4c13-9b46-0f43e297f7b2'),(109,'craft','m170903_192801_longblob_for_queue_jobs','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','f862410d-421c-4d9d-911a-9d25020dc4e2'),(110,'craft','m170914_204621_asset_cache_shuffle','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','a3a2372a-7f88-4773-82c1-bf07b75025b6'),(111,'craft','m171011_214115_site_groups','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','c73bd6cf-f2ac-4434-84c0-f699791a48ff'),(112,'craft','m171012_151440_primary_site','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','5bb43f67-95d6-438a-b521-947dd1af35a0'),(113,'craft','m171013_142500_transform_interlace','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','f3f28bcf-f0f0-4831-b20b-d358df337a9b'),(114,'craft','m171016_092553_drop_position_select','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','b879fbbc-ca16-4ab4-b689-0630e2758c6e'),(115,'craft','m171016_221244_less_strict_translation_method','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','047619d6-a951-4124-8cd7-0b42889b603e'),(116,'craft','m171107_000000_assign_group_permissions','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','754b221b-086b-4678-885f-816820b44415'),(117,'craft','m171117_000001_templatecache_index_tune','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','4e095cd3-7b58-4fdd-b03c-3f9b9ecd6bd3'),(118,'craft','m171126_105927_disabled_plugins','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','ed0895c0-1608-4fb6-8eea-ae8142c46660'),(119,'craft','m171130_214407_craftidtokens_table','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','24cf0c4a-f005-47e9-a40e-95e268c145a8'),(120,'craft','m171202_004225_update_email_settings','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','22cadcc8-55a9-4c01-a613-bffad95bfff3'),(121,'craft','m171204_000001_templatecache_index_tune_deux','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','12de35ab-2b75-4a79-ac3d-7ac49fcfc6ec'),(122,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','04894a35-c9f5-4633-9b0e-6681391f2923'),(123,'craft','m171218_143135_longtext_query_column','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','6ea20029-22b8-4e39-8aec-d30f8ffe7ce2'),(124,'craft','m171231_055546_environment_variables_to_aliases','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','c81270a2-9759-4e6f-8db1-b2b6724b5d33'),(125,'craft','m180113_153740_drop_users_archived_column','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','11ae60c8-4612-47c3-a0ee-31033dae5c34'),(126,'craft','m180122_213433_propagate_entries_setting','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','c495aaef-a61f-4ee4-abb7-8024192aa155'),(127,'craft','m180124_230459_fix_propagate_entries_values','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','e11bb7f5-1cde-402c-a54b-03ad7f845e5e'),(128,'craft','m180128_235202_set_tag_slugs','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','05c6e105-e720-49f7-8ea1-1d37faa66b6d'),(129,'craft','m180202_185551_fix_focal_points','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','06f84f62-3a34-4a02-b080-85d2a5772f8a'),(130,'craft','m180217_172123_tiny_ints','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','b3fc9701-f521-40e5-958f-d29952d1a0d8'),(131,'craft','m180321_233505_small_ints','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','f6c957b4-ee75-46bc-a479-74075d4d06b3'),(132,'craft','m180328_115523_new_license_key_statuses','2021-01-18 20:25:25','2021-01-18 20:25:25','2021-01-18 20:25:25','e6698c3c-e7de-4f40-8d7c-51e61d1b7b46'),(133,'craft','m180404_182320_edition_changes','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','fb04b651-40af-42ea-b115-2b1fdfab75e3'),(134,'craft','m180411_102218_fix_db_routes','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','880c8736-490d-4bbf-91bc-ad527d26c049'),(135,'craft','m180416_205628_resourcepaths_table','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','dfacc1f8-75c5-439c-ab20-76b558bae4e2'),(136,'craft','m180418_205713_widget_cleanup','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','1e1c865c-d213-4a41-9d27-c54d6fad6bc2'),(137,'craft','m180425_203349_searchable_fields','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','e75019a7-8bba-402c-96ba-d6ee32aa26e5'),(138,'craft','m180516_153000_uids_in_field_settings','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','f72cbc0f-cc55-412e-a675-20be588c0754'),(139,'craft','m180517_173000_user_photo_volume_to_uid','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','70934f7c-c48b-4b74-aebf-26911d56907f'),(140,'craft','m180518_173000_permissions_to_uid','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','4fa3d847-3a44-439f-8add-3c16a39c49c6'),(141,'craft','m180520_173000_matrix_context_to_uids','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','5654b7e7-37e8-44f5-840f-ce4d1b53f33b'),(142,'craft','m180521_172900_project_config_table','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','fa96c543-fe71-4aa0-afbf-64286355e05f'),(143,'craft','m180521_173000_initial_yml_and_snapshot','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','369c250c-c8c5-4782-961b-723ad2f81ce3'),(144,'craft','m180731_162030_soft_delete_sites','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','842c9898-bf9d-4a1f-96de-03ac8e68b59b'),(145,'craft','m180810_214427_soft_delete_field_layouts','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','d15cdd9d-a5a4-4fa0-bd57-af3ac17145c1'),(146,'craft','m180810_214439_soft_delete_elements','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','129a4e76-7068-4447-9723-ae5c77073cb2'),(147,'craft','m180824_193422_case_sensitivity_fixes','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','a121cd5f-8ba1-40c6-8f48-3111b78761b8'),(148,'craft','m180901_151639_fix_matrixcontent_tables','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','886c9d8c-522e-4fe7-a6ac-090161f9265e'),(149,'craft','m180904_112109_permission_changes','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','d34b8221-05d6-477b-b64a-4cf1c8243680'),(150,'craft','m180910_142030_soft_delete_sitegroups','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','9dd63f21-8fbc-492b-af31-e82e4f6d76ac'),(151,'craft','m181011_160000_soft_delete_asset_support','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','13f5931b-19bb-41da-a330-518f00779a39'),(152,'craft','m181016_183648_set_default_user_settings','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','b4ceba0a-2847-4206-aa76-b7a313ab99bf'),(153,'craft','m181017_225222_system_config_settings','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','0a979da9-33cd-4c73-938e-089d91a15204'),(154,'craft','m181018_222343_drop_userpermissions_from_config','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','3372ff9f-353a-4b87-8a04-75155164c74e'),(155,'craft','m181029_130000_add_transforms_routes_to_config','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','06660a5f-14e3-4360-a719-0593b2eb1d68'),(156,'craft','m181112_203955_sequences_table','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','b28fa352-22dd-41f8-a8bb-603edd9069e9'),(157,'craft','m181121_001712_cleanup_field_configs','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','9b3bf6c8-3e21-46de-81d9-14fe0543b657'),(158,'craft','m181128_193942_fix_project_config','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','b377ddca-ffa6-4207-a041-8033cfc3f477'),(159,'craft','m181130_143040_fix_schema_version','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','688c3b7f-6e57-49e4-a741-58e14a979938'),(160,'craft','m181211_143040_fix_entry_type_uids','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','2a70e402-71a0-474b-aa45-2eca097624ad'),(161,'craft','m181217_153000_fix_structure_uids','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','b228adf9-c2ea-4fb1-87a8-220d3a96fac1'),(162,'craft','m190104_152725_store_licensed_plugin_editions','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','e754b02c-38ac-4924-99a4-257f7e11391c'),(163,'craft','m190108_110000_cleanup_project_config','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','6c5e4382-5de1-4afb-94b0-759663a74a69'),(164,'craft','m190108_113000_asset_field_setting_change','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','008562e2-5e84-4d70-8aaa-5a744bc2b172'),(165,'craft','m190109_172845_fix_colspan','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','2f5b3502-4951-4a9c-b026-987aeb124b7e'),(166,'craft','m190110_150000_prune_nonexisting_sites','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','37d20297-fc9e-4a50-8aa7-7cd73f9d1bc3'),(167,'craft','m190110_214819_soft_delete_volumes','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','653958c2-b003-4097-8927-cd01e1111686'),(168,'craft','m190112_124737_fix_user_settings','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','4bd2ca5f-945c-445f-899d-3066f4e22d17'),(169,'craft','m190112_131225_fix_field_layouts','2021-01-18 20:25:26','2021-01-18 20:25:26','2021-01-18 20:25:26','affcae81-2163-4335-b08a-97c186767594'),(170,'craft','m190112_201010_more_soft_deletes','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','4836e3d5-5446-41cc-8bfe-9c58756003fe'),(171,'craft','m190114_143000_more_asset_field_setting_changes','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','4d30f509-210f-40e6-8c4d-6a5e7f388d26'),(172,'craft','m190121_120000_rich_text_config_setting','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','60dfc14e-80d4-44da-9c27-9659e6f2e71d'),(173,'craft','m190125_191628_fix_email_transport_password','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','ab65f06c-6221-4857-a702-04b54a6fb935'),(174,'craft','m190128_181422_cleanup_volume_folders','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','6739dcf7-198d-41ce-acc2-28ac88cb3be2'),(175,'craft','m190205_140000_fix_asset_soft_delete_index','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','86cefe2b-a91c-46d0-9d77-fd083630ce5f'),(176,'craft','m190218_143000_element_index_settings_uid','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','803f3b37-8431-4d32-b063-1de8b2fdb6c9'),(177,'craft','m190312_152740_element_revisions','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','a96386cc-2b92-4948-975c-50aeddb53f82'),(178,'craft','m190327_235137_propagation_method','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','2888e96f-ced8-4f05-9618-f0acb4be01fb'),(179,'craft','m190401_223843_drop_old_indexes','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','ebfbc7aa-45c1-4c0e-a6d8-7b34a0883173'),(180,'craft','m190416_014525_drop_unique_global_indexes','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','a0a38b5b-e53e-48d8-8df3-3dbbf37f2fe1'),(181,'craft','m190417_085010_add_image_editor_permissions','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','54c31caf-6e87-42fb-89e5-ab4d0da72e5b'),(182,'craft','m190502_122019_store_default_user_group_uid','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','db28818d-046a-4e0e-a2a5-68210cf344fd'),(183,'craft','m190504_150349_preview_targets','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','f581f2a1-5c2b-441f-97b0-26ce051bbe02'),(184,'craft','m190516_184711_job_progress_label','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','b6d0921d-5791-437f-aab0-80adf67be039'),(185,'craft','m190523_190303_optional_revision_creators','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','e70cd9ce-ec9b-4af1-80ea-3f09ed56bb71'),(186,'craft','m190529_204501_fix_duplicate_uids','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','2a404c2c-532f-4c0d-8bf4-753046a604a9'),(187,'craft','m190605_223807_unsaved_drafts','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','2c4307e9-3514-4168-b849-dfe973175872'),(188,'craft','m190607_230042_entry_revision_error_tables','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','43d9ba16-7b7d-4d07-9d55-2156801d6660'),(189,'craft','m190608_033429_drop_elements_uid_idx','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','3b2b446e-c8f3-4bed-98f0-d777c6a3591b'),(190,'craft','m190617_164400_add_gqlschemas_table','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','5695a98d-334f-41cd-874a-f6bef37c0ae9'),(191,'craft','m190624_234204_matrix_propagation_method','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','05cc2e7a-ade8-4127-abce-9cf22a945be8'),(192,'craft','m190711_153020_drop_snapshots','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','6838b629-8a31-41b9-b6c9-431894c2e65b'),(193,'craft','m190712_195914_no_draft_revisions','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','91a557a0-ccf2-45e5-b284-67968fcad6ac'),(194,'craft','m190723_140314_fix_preview_targets_column','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','9e5ad2c1-0fc8-411f-b3be-d6a352d31651'),(195,'craft','m190820_003519_flush_compiled_templates','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','5360602a-09a7-4a1d-8561-5aa35fe77648'),(196,'craft','m190823_020339_optional_draft_creators','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','42362e6b-62e2-4b40-845f-4fd4445736d1'),(197,'craft','m190913_152146_update_preview_targets','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','2fee1258-97ba-4ed7-abe9-57a2b2d96854'),(198,'craft','m191107_122000_add_gql_project_config_support','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','ab982301-0428-4f0d-a2af-78a4e341f437'),(199,'craft','m191204_085100_pack_savable_component_settings','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','898b26f7-4a0f-4d38-b709-7a9cbcd2a14c'),(200,'craft','m191206_001148_change_tracking','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','457dce6c-21f9-4d39-9d3e-59d1a55915e0'),(201,'craft','m191216_191635_asset_upload_tracking','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','4b3d9ff2-adbc-4449-8917-dff8d5dba5b9'),(202,'craft','m191222_002848_peer_asset_permissions','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','3b7facf2-eb3b-4b0b-b691-e42a56ff51cd'),(203,'craft','m200127_172522_queue_channels','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','992235cb-e342-424e-beb7-ee20257a3eda'),(204,'craft','m200211_175048_truncate_element_query_cache','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','846f5144-bd58-453d-b40e-e5ef158ffa0b'),(205,'craft','m200213_172522_new_elements_index','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','5e5d3526-d905-4d15-8f75-6cdfd26bb53e'),(206,'craft','m200228_195211_long_deprecation_messages','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','0c0675c1-2356-43b3-a259-53b00609b745'),(207,'craft','m200306_054652_disabled_sites','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','6f4277ec-8fc5-43bf-9994-7ebe1970a519'),(208,'craft','m200522_191453_clear_template_caches','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','85285fea-ba64-4eda-a617-a723f6298119'),(209,'craft','m200606_231117_migration_tracks','2021-01-18 20:25:27','2021-01-18 20:25:27','2021-01-18 20:25:27','8e0933ec-481c-452c-ada4-364555a0dc3e'),(210,'craft','m200619_215137_title_translation_method','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','b3f61858-7c8b-41bc-877e-326feda50e2d'),(211,'craft','m200620_005028_user_group_descriptions','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','07c8d58b-47de-486c-998a-49046e258506'),(212,'craft','m200620_230205_field_layout_changes','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','fbf5fb50-31ca-406b-8268-42145adcddd8'),(213,'craft','m200625_131100_move_entrytypes_to_top_project_config','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','479c17e7-55b1-44e7-bdf5-a541755e4c50'),(214,'craft','m200629_112700_remove_project_config_legacy_files','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','e041345b-5db0-4a1c-8bcb-671a76cf7d12'),(215,'craft','m200630_183000_drop_configmap','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','a5e861ec-a064-4cc4-b9df-69f64a0b43e5'),(216,'craft','m200715_113400_transform_index_error_flag','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','22af0e74-3dcf-4a2f-a81b-bf460b3b4a31'),(217,'craft','m200716_110900_replace_file_asset_permissions','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','f189451a-3526-48c6-a4f4-cb1b60a53cfc'),(218,'craft','m200716_153800_public_token_settings_in_project_config','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','71d03c44-498c-4eae-8803-a3f02d81963f'),(219,'craft','m200720_175543_drop_unique_constraints','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','c9e26f54-a46f-47c0-aaf0-f6527db279e2'),(220,'craft','m200825_051217_project_config_version','2021-01-18 20:25:28','2021-01-18 20:25:28','2021-01-18 20:25:28','b659530e-d0fe-41a8-9dc9-f4fbb0254eaa'),(221,'plugin:feed-me','Install','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','f8bbfcf9-030f-4f7b-a7c1-4655a303257e'),(222,'plugin:feed-me','m180305_000000_migrate_feeds','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','ef48a166-d740-4be0-87fc-440393b33e7e'),(223,'plugin:feed-me','m181113_000000_add_paginationNode','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','db3ddf50-a6d0-4468-b615-0ed5e0f4527c'),(224,'plugin:feed-me','m190201_000000_update_asset_feeds','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','478c5513-d7cd-43f5-a2fd-04a99a84bad0'),(225,'plugin:feed-me','m190320_000000_renameLocale','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','2fb399de-9614-41d2-938c-fb4eb32f56ca'),(226,'plugin:feed-me','m190406_000000_sortOrder','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','a7c24a97-19f2-4fc4-88dd-5a1321de2711'),(227,'plugin:feed-me','m201106_202042_singleton_feeds','2021-01-18 20:32:27','2021-01-18 20:32:27','2021-01-18 20:32:27','d499df12-cd3f-4f20-9e6d-3335f22f6f00'),(228,'plugin:redactor','m180430_204710_remove_old_plugins','2021-01-18 20:32:33','2021-01-18 20:32:33','2021-01-18 20:32:33','aafe5a96-ab53-42a2-a081-621db2c522de'),(229,'plugin:redactor','Install','2021-01-18 20:32:33','2021-01-18 20:32:33','2021-01-18 20:32:33','3a378e12-eb6d-4b88-9bbe-b8eff03cc272'),(230,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2021-01-18 20:32:33','2021-01-18 20:32:33','2021-01-18 20:32:33','7d1b336a-3ef1-4d8f-ac19-8a857b2b9e38'),(231,'craft','m201116_190500_asset_title_translation_method','2021-03-02 20:02:32','2021-03-02 20:02:32','2021-03-02 20:02:32','f779bc2e-dccb-47f4-bf53-7b08e9f5e692'),(232,'craft','m201124_003555_plugin_trials','2021-03-02 20:02:32','2021-03-02 20:02:32','2021-03-02 20:02:32','edbe0819-bae8-45ee-8ef8-a9b4f6ada319'),(233,'craft','m210209_135503_soft_delete_field_groups','2021-03-02 20:03:14','2021-03-02 20:03:14','2021-03-02 20:03:14','17fd97a7-cd29-41c0-9507-7f5b61d913c6'),(234,'craft','m210212_223539_delete_invalid_drafts','2021-03-02 20:03:14','2021-03-02 20:03:14','2021-03-02 20:03:14','aa55735f-98d6-49ac-b25a-5a983d871f0a'),(235,'craft','m210214_202731_track_saved_drafts','2021-03-02 20:03:14','2021-03-02 20:03:14','2021-03-02 20:03:14','20ddc9f0-0e09-4c0b-856e-5e012f19a54b');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_plugins` VALUES (3,'feed-me','4.3.5.1','4.3.0','unknown',NULL,'2021-01-18 20:32:27','2021-01-18 20:32:27','2021-03-02 19:47:38','c30cf5a8-34d1-4afc-82c2-a7bd0d4d8651'),(4,'redactor','2.8.5','2.3.0','unknown',NULL,'2021-01-18 20:32:33','2021-01-18 20:32:33','2021-03-02 19:37:23','46d01f5d-3e27-44fe-8144-fbd0b932a822');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_projectconfig`
--

LOCK TABLES `craft_projectconfig` WRITE;
/*!40000 ALTER TABLE `craft_projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_projectconfig` VALUES ('dateModified','1614715403'),('email.fromEmail','\"ryan@mijingo.com\"'),('email.fromName','\"Downlink\"'),('email.template','null'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.autocapitalize','true'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.autocomplete','false'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.autocorrect','true'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.class','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.disabled','false'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.id','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.instructions','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.label','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.max','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.min','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.name','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.orientation','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.placeholder','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.readonly','false'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.requirable','false'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.size','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.step','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.tip','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.title','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.warning','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.0.width','100'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.fieldUid','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.instructions','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.label','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.required','\"1\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.tip','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.warning','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.elements.1.width','100'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.name','\"Content\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.fieldLayouts.fa1fa13e-dfac-40f6-8fe5-5066b6e2510f.tabs.0.sortOrder','1'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.handle','\"homepage\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.hasTitleField','true'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.name','\"Homepage\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.section','\"b2bfca42-e66d-4231-8a3c-7245e9b49ac1\"'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.sortOrder','0'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.titleFormat','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.titleTranslationKeyFormat','null'),('entryTypes.5610066d-2f20-4444-a547-eb560bda26a5.titleTranslationMethod','\"site\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.autocapitalize','true'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.autocomplete','false'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.autocorrect','true'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.class','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.disabled','false'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.id','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.instructions','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.label','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.max','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.min','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.name','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.orientation','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.placeholder','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.readonly','false'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.requirable','false'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.size','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.step','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.tip','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.title','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.warning','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.0.width','100'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.fieldUid','\"9491ba1e-9c32-45fe-a97f-b0d25dc40071\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.instructions','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.label','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.required','\"0\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.tip','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.warning','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.1.width','100'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.fieldUid','\"1d0a4430-e8d9-49c3-b910-64c5008d3f3b\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.instructions','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.label','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.required','\"0\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.tip','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.warning','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.elements.2.width','100'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.name','\"Podcast Details\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.fieldLayouts.d64a50e0-3937-4444-a8f4-1173a41390a0.tabs.0.sortOrder','1'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.handle','\"default\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.hasTitleField','true'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.name','\"Default\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.section','\"b69d7902-4ddd-45fb-8c40-80d77d3a82eb\"'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.sortOrder','0'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.titleFormat','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.titleTranslationKeyFormat','null'),('entryTypes.86d15507-220a-4d5c-b1d0-eab2b173619f.titleTranslationMethod','\"site\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.autocapitalize','true'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.autocomplete','false'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.autocorrect','true'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.class','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.disabled','false'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.id','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.instructions','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.label','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.max','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.min','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.name','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.orientation','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.placeholder','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.readonly','false'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.requirable','false'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.size','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.step','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.tip','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.title','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.warning','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.0.width','100'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.fieldUid','\"736e7c2a-c6c7-4609-b1f2-38e7709e56cf\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.instructions','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.label','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.required','\"0\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.tip','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.warning','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.1.width','100'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.fieldUid','\"cf2dac30-56a5-4a12-91a4-ed35d2eed4ab\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.instructions','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.label','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.required','\"0\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.tip','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.warning','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.2.width','100'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.fieldUid','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.instructions','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.label','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.required','\"0\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.tip','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.warning','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.3.width','100'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.fieldUid','\"b72c1e8b-f22a-42b5-846d-8314c08dd793\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.instructions','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.label','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.required','\"0\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.tip','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.warning','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.elements.4.width','100'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.name','\"Default\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.fieldLayouts.2b9c7d28-9188-4b33-812c-932cd13f32ca.tabs.0.sortOrder','1'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.handle','\"default\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.hasTitleField','true'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.name','\"Default\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.section','\"9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34\"'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.sortOrder','0'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.titleFormat','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.titleTranslationKeyFormat','null'),('entryTypes.a95fdc3d-b143-489a-8ee7-22ae7268c278.titleTranslationMethod','\"site\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.autocapitalize','true'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.autocomplete','false'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.autocorrect','true'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.class','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.disabled','false'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.id','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.instructions','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.label','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.max','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.min','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.name','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.orientation','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.placeholder','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.readonly','false'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.requirable','false'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.size','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.step','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.tip','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.title','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.warning','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.0.width','100'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.fieldUid','\"8cb1f015-2f0a-4758-89c3-fbb35b49a190\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.instructions','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.label','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.required','\"0\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.tip','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.warning','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.1.width','100'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.fieldUid','\"4a7f66f8-f0f6-47b7-89de-5eca5fc48600\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.instructions','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.label','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.required','\"0\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.tip','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.warning','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.elements.2.width','100'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.name','\"Link Content\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.fieldLayouts.02708298-ea20-41d0-a674-6fba7a7d8c0c.tabs.0.sortOrder','1'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.handle','\"link\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.hasTitleField','true'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.name','\"Link\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.section','\"9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34\"'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.sortOrder','0'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.titleFormat','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.titleTranslationKeyFormat','null'),('entryTypes.c1d8279b-ea8f-4690-9ecf-97c82d6f64ca.titleTranslationMethod','\"site\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.autocapitalize','true'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.autocomplete','false'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.autocorrect','true'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.class','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.disabled','false'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.id','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.instructions','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.label','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.max','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.min','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.name','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.orientation','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.placeholder','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.readonly','false'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.requirable','false'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.size','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.step','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.tip','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.title','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.warning','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.0.width','100'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.fieldUid','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.instructions','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.label','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.required','\"0\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.tip','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.warning','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.1.width','100'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.fieldUid','\"6f055d5e-e5e3-4363-81de-c7dff55ad3b3\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.instructions','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.label','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.required','\"0\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.tip','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.warning','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.elements.2.width','100'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.name','\"Review Content\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.fieldLayouts.e400c5e4-326e-47e1-9074-cc4a1de24b82.tabs.0.sortOrder','1'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.handle','\"default\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.hasTitleField','true'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.name','\"Default\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.section','\"0464fede-3a5f-4c7d-9de1-c1b8021eaa8d\"'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.sortOrder','0'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.titleFormat','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.titleTranslationKeyFormat','null'),('entryTypes.e1d02456-6cc1-4385-9e98-73bd2a5e4abf.titleTranslationMethod','\"site\"'),('fieldGroups.183cebdb-02fe-4dd5-8b3e-450522d38342.name','\"Review\"'),('fieldGroups.d6dcd64b-f047-48ff-9336-a67a6c8f8541.name','\"Podcast\"'),('fieldGroups.f445487e-f6a2-471c-a08b-3096f57da2d0.name','\"Default\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.contentColumnType','\"text\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.fieldGroup','\"d6dcd64b-f047-48ff-9336-a67a6c8f8541\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.handle','\"episodeDescription\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.instructions','\"\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.name','\"Episode Description\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.searchable','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.availableTransforms','\"*\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.availableVolumes','\"*\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.cleanupHtml','\"1\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.columnType','\"text\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.configSelectionMode','\"choose\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.defaultTransform','\"\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.manualConfig','\"\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.purifierConfig','null'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.purifyHtml','\"1\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.redactorConfig','\"\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.removeEmptyTags','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.removeInlineStyles','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.removeNbsp','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.showHtmlButtonForNonAdmins','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.showUnpermittedFiles','false'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.showUnpermittedVolumes','true'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.settings.uiMode','\"enlarged\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.translationKeyFormat','null'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.translationMethod','\"none\"'),('fields.1d0a4430-e8d9-49c3-b910-64c5008d3f3b.type','\"craft\\\\redactor\\\\Field\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.contentColumnType','\"text\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.handle','\"linkDescription\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.instructions','\"\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.name','\"Link Description\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.searchable','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.availableTransforms','\"*\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.availableVolumes','\"*\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.cleanupHtml','\"1\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.columnType','\"text\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.configSelectionMode','\"choose\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.defaultTransform','\"\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.manualConfig','\"\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.purifierConfig','null'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.purifyHtml','\"1\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.redactorConfig','\"Standard.json\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.removeEmptyTags','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.removeInlineStyles','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.removeNbsp','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.showHtmlButtonForNonAdmins','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.showUnpermittedFiles','false'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.showUnpermittedVolumes','true'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.settings.uiMode','\"enlarged\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.translationKeyFormat','null'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.translationMethod','\"none\"'),('fields.4a7f66f8-f0f6-47b7-89de-5eca5fc48600.type','\"craft\\\\redactor\\\\Field\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.contentColumnType','\"text\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.fieldGroup','\"183cebdb-02fe-4dd5-8b3e-450522d38342\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.handle','\"bookASIN\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.instructions','\"The ASIN from Amazon.com for this book. Your affiliate ID will be automatically included in the URL. \"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.name','\"Book ASIN\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.searchable','true'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.byteLimit','null'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.charLimit','null'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.code','false'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.columnType','\"text\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.initialRows','\"4\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.multiline','\"\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.placeholder','\"\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.settings.uiMode','\"normal\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.translationKeyFormat','null'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.translationMethod','\"none\"'),('fields.6f055d5e-e5e3-4363-81de-c7dff55ad3b3.type','\"craft\\\\fields\\\\PlainText\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.contentColumnType','\"string\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.handle','\"teaserImage\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.instructions','\"\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.name','\"Teaser Image\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.searchable','true'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.allowedKinds.0','\"image\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.allowSelfRelations','false'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.allowUploads','true'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.defaultUploadLocationSource','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.defaultUploadLocationSubpath','\"\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.limit','\"1\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.localizeRelations','false'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.previewMode','\"full\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.restrictFiles','\"1\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.selectionLabel','\"Add image to use in homepage/listing page teaser.\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.showSiteMenu','true'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.showUnpermittedFiles','false'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.showUnpermittedVolumes','true'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.singleUploadLocationSource','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.singleUploadLocationSubpath','\"\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.source','null'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.sources.0','\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.targetSiteId','null'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.useSingleFolder','false'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.validateRelatedElements','false'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.settings.viewMode','\"list\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.translationKeyFormat','null'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.translationMethod','\"site\"'),('fields.736e7c2a-c6c7-4609-b1f2-38e7709e56cf.type','\"craft\\\\fields\\\\Assets\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.contentColumnType','\"text\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.handle','\"linkUrl\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.instructions','\"\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.name','\"Link URL\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.searchable','true'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.byteLimit','null'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.charLimit','null'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.code','false'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.columnType','\"text\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.initialRows','\"4\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.multiline','\"\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.placeholder','\"\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.settings.uiMode','\"normal\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.translationKeyFormat','null'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.translationMethod','\"none\"'),('fields.8cb1f015-2f0a-4758-89c3-fbb35b49a190.type','\"craft\\\\fields\\\\PlainText\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.contentColumnType','\"string\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.fieldGroup','\"d6dcd64b-f047-48ff-9336-a67a6c8f8541\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.handle','\"episodeFile\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.instructions','\"\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.name','\"Episode File\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.searchable','true'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.allowedKinds.0','\"audio\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.allowSelfRelations','false'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.allowUploads','true'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.defaultUploadLocationSource','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.defaultUploadLocationSubpath','\"{slug}\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.limit','\"1\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.localizeRelations','false'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.previewMode','\"full\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.restrictFiles','\"1\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.selectionLabel','\"Add the MP3 file for this episode.\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.showSiteMenu','true'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.showUnpermittedFiles','false'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.showUnpermittedVolumes','true'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.singleUploadLocationSource','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.singleUploadLocationSubpath','\"\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.source','null'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.sources.0','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.targetSiteId','null'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.useSingleFolder','false'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.validateRelatedElements','false'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.settings.viewMode','\"list\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.translationKeyFormat','null'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.translationMethod','\"site\"'),('fields.9491ba1e-9c32-45fe-a97f-b0d25dc40071.type','\"craft\\\\fields\\\\Assets\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.contentColumnType','\"string\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.handle','\"tags\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.instructions','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.name','\"Tags\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.searchable','true'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.allowLimit','false'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.allowMultipleSources','false'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.allowSelfRelations','false'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.limit','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.localizeRelations','false'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.selectionLabel','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.showSiteMenu','true'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.source','\"taggroup:237da2ff-504f-4e2c-bf6c-152bf831c8f1\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.sources','\"*\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.targetSiteId','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.validateRelatedElements','false'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.settings.viewMode','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.translationKeyFormat','null'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.translationMethod','\"site\"'),('fields.b72c1e8b-f22a-42b5-846d-8314c08dd793.type','\"craft\\\\fields\\\\Tags\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.contentColumnType','\"text\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.handle','\"teaserCopy\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.instructions','\"\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.name','\"Teaser Copy\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.searchable','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.availableTransforms','\"*\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.availableVolumes','\"*\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.cleanupHtml','\"1\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.columnType','\"text\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.configSelectionMode','\"choose\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.defaultTransform','\"\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.manualConfig','\"\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.purifierConfig','null'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.purifyHtml','\"1\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.redactorConfig','\"Simple.json\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.removeEmptyTags','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.removeInlineStyles','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.removeNbsp','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.showHtmlButtonForNonAdmins','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.showUnpermittedFiles','false'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.showUnpermittedVolumes','true'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.settings.uiMode','\"enlarged\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.translationKeyFormat','null'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.translationMethod','\"none\"'),('fields.cf2dac30-56a5-4a12-91a4-ed35d2eed4ab.type','\"craft\\\\redactor\\\\Field\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.contentColumnType','\"string\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.fieldGroup','\"f445487e-f6a2-471c-a08b-3096f57da2d0\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.handle','\"body\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.instructions','\"\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.name','\"Body\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.searchable','true'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.settings.contentTable','\"{{%matrixcontent_body}}\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.settings.maxBlocks','null'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.settings.minBlocks','null'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.settings.propagationMethod','\"all\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.translationKeyFormat','null'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.translationMethod','\"site\"'),('fields.f4696807-fad3-4e93-a26a-e1946637d383.type','\"craft\\\\fields\\\\Matrix\"'),('graphql.publicToken.enabled','false'),('graphql.publicToken.expiryDate','null'),('graphql.schemas.831c6792-c373-4eaa-b38d-caa740ca83d2.isPublic','true'),('graphql.schemas.831c6792-c373-4eaa-b38d-caa740ca83d2.name','\"Public Schema\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.field','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.fieldUid','\"c5a9f115-5b57-497d-9a9f-c76ef6a8881e\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.label','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.required','\"0\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.tip','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.warning','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.elements.0.width','100'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.name','\"Content\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fieldLayouts.ae2817ec-1083-4a4d-b4bb-0a2d71acac2c.tabs.0.sortOrder','1'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.contentColumnType','\"text\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.fieldGroup','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.handle','\"textContent\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.instructions','\"\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.name','\"Content\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.searchable','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.availableTransforms','\"*\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.availableVolumes','\"*\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.cleanupHtml','\"1\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.columnType','\"text\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.configSelectionMode','\"choose\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.defaultTransform','\"\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.manualConfig','\"\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.purifierConfig','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.purifyHtml','\"1\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.redactorConfig','\"Standard.json\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.removeEmptyTags','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.removeInlineStyles','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.removeNbsp','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.showHtmlButtonForNonAdmins','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.showUnpermittedFiles','false'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.showUnpermittedVolumes','true'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.settings.uiMode','\"enlarged\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.translationKeyFormat','null'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.translationMethod','\"none\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.fields.c5a9f115-5b57-497d-9a9f-c76ef6a8881e.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.handle','\"text\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.name','\"Text\"'),('matrixBlockTypes.39b7122f-8343-4bfd-ba42-51db49838e4a.sortOrder','1'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.field','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.fieldUid','\"1a3b8507-a4a7-472b-9b10-e99f057d5cd6\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.label','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.required','\"0\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.tip','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.warning','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.0.width','100'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.fieldUid','\"b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.instructions','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.label','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.required','\"0\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.tip','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.warning','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.elements.1.width','100'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.name','\"Content\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fieldLayouts.17e44b1b-29eb-4b2d-af27-7cabc3c1ac4a.tabs.0.sortOrder','1'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.contentColumnType','\"text\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.fieldGroup','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.handle','\"quote\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.instructions','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.name','\"Quote\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.searchable','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.availableTransforms','\"*\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.availableVolumes','\"*\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.cleanupHtml','\"1\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.columnType','\"text\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.configSelectionMode','\"choose\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.defaultTransform','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.manualConfig','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.purifierConfig','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.purifyHtml','\"1\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.redactorConfig','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.removeEmptyTags','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.removeInlineStyles','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.removeNbsp','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.showHtmlButtonForNonAdmins','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.showUnpermittedFiles','false'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.showUnpermittedVolumes','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.settings.uiMode','\"enlarged\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.translationKeyFormat','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.translationMethod','\"none\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.1a3b8507-a4a7-472b-9b10-e99f057d5cd6.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.contentColumnType','\"text\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.fieldGroup','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.handle','\"citation\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.instructions','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.name','\"Citation\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.searchable','true'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.byteLimit','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.charLimit','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.code','false'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.columnType','\"text\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.initialRows','\"4\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.multiline','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.placeholder','\"\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.settings.uiMode','\"normal\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.translationKeyFormat','null'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.translationMethod','\"none\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.fields.b0d7dcf1-30a9-4fb9-90ba-3fdf5927e19c.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.handle','\"blockquote\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.name','\"Blockquote\"'),('matrixBlockTypes.67031931-0155-4204-8483-32624008ae23.sortOrder','2'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.field','\"f4696807-fad3-4e93-a26a-e1946637d383\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.fieldUid','\"bc8a2715-5172-471b-8357-589ba0ab3209\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.label','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.required','\"1\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.tip','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.warning','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.0.width','100'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.fieldUid','\"1beade96-c14b-406a-896b-e052a13ec594\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.instructions','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.label','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.required','\"0\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.tip','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.warning','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.1.width','100'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.fieldUid','\"942db2b2-2993-4398-95a5-fa14532c58d0\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.instructions','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.label','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.required','\"0\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.tip','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.warning','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.elements.2.width','100'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.name','\"Content\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fieldLayouts.6fc4afe9-a01f-45bf-a9cd-ce8b713d8d40.tabs.0.sortOrder','1'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.contentColumnType','\"text\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.fieldGroup','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.handle','\"caption\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.instructions','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.name','\"Caption\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.searchable','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.byteLimit','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.charLimit','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.code','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.columnType','\"text\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.initialRows','\"4\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.multiline','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.placeholder','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.settings.uiMode','\"normal\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.translationKeyFormat','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.translationMethod','\"none\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.1beade96-c14b-406a-896b-e052a13ec594.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.contentColumnType','\"string\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.fieldGroup','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.handle','\"layout\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.instructions','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.name','\"Layout\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.searchable','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.optgroups','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.0.1','\"Left\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.1.1','\"left\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.0.1','\"Right\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.1.1','\"right\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.0.1','\"Full\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.1.1','\"full\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.translationKeyFormat','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.translationMethod','\"none\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.942db2b2-2993-4398-95a5-fa14532c58d0.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.contentColumnType','\"string\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.fieldGroup','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.handle','\"image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.instructions','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.name','\"Image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.searchable','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.allowedKinds.0','\"image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.allowSelfRelations','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.allowUploads','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.defaultUploadLocationSource','\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.defaultUploadLocationSubpath','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.limit','\"1\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.localizeRelations','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.previewMode','\"full\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.restrictFiles','\"1\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.selectionLabel','\"Add an image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.showSiteMenu','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.showUnpermittedFiles','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.showUnpermittedVolumes','true'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.singleUploadLocationSource','\"volume:7c831f23-da90-4f0d-90a2-454375ee2e8e\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.singleUploadLocationSubpath','\"\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.source','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.sources.0','\"volume:33c8318a-f8ad-43f7-8231-448c204a6ed9\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.targetSiteId','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.useSingleFolder','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.validateRelatedElements','false'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.settings.viewMode','\"list\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.translationKeyFormat','null'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.translationMethod','\"site\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.fields.bc8a2715-5172-471b-8357-589ba0ab3209.type','\"craft\\\\fields\\\\Assets\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.handle','\"image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.name','\"Image\"'),('matrixBlockTypes.67470af9-2f4e-4aac-b68c-d4c787c163e4.sortOrder','3'),('plugins.feed-me.edition','\"standard\"'),('plugins.feed-me.enabled','true'),('plugins.feed-me.schemaVersion','\"4.3.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.enableVersioning','true'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.handle','\"review\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.name','\"Review\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.propagationMethod','\"all\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.enabledByDefault','true'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.hasUrls','true'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.template','\"entry\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.uriFormat','\"review/{slug}\"'),('sections.0464fede-3a5f-4c7d-9de1-c1b8021eaa8d.type','\"channel\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.enableVersioning','true'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.handle','\"blog\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.name','\"Blog\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.propagationMethod','\"all\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.enabledByDefault','true'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.hasUrls','true'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.template','\"entry\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.uriFormat','\"blog/{postDate|date(\\\"Y\\\")}/{postDate|date(\\\"m\\\")}/{slug}\"'),('sections.9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34.type','\"channel\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.enableVersioning','true'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.handle','\"homepage\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.name','\"Homepage\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.propagationMethod','\"all\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.enabledByDefault','true'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.hasUrls','true'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.template','\"index\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.uriFormat','\"__home__\"'),('sections.b2bfca42-e66d-4231-8a3c-7245e9b49ac1.type','\"single\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.enableVersioning','true'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.handle','\"podcast\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.name','\"Podcast\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.propagationMethod','\"all\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.enabledByDefault','true'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.hasUrls','true'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.template','\"entry\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.siteSettings.35c13b6c-aaee-499a-9580-96963583b7f4.uriFormat','\"podcast/{slug}\"'),('sections.b69d7902-4ddd-45fb-8c40-80d77d3a82eb.type','\"channel\"'),('siteGroups.8d76cad1-25d8-4b50-8cae-e68b02cac669.name','\"Downlink (en-US)\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.baseUrl','\"$BASE_URL\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.enabled','true'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.handle','\"en_us\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.hasUrls','true'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.language','\"en-US\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.name','\"Downlink (en-US)\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.primary','true'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.siteGroup','\"8d76cad1-25d8-4b50-8cae-e68b02cac669\"'),('sites.35c13b6c-aaee-499a-9580-96963583b7f4.sortOrder','1'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"Downlink\"'),('system.schemaVersion','\"3.6.4\"'),('system.timeZone','\"UTC\"'),('tagGroups.237da2ff-504f-4e2c-bf6c-152bf831c8f1.handle','\"default\"'),('tagGroups.237da2ff-504f-4e2c-bf6c-152bf831c8f1.name','\"Default\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.autocapitalize','true'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.autocomplete','false'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.autocorrect','true'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.class','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.disabled','false'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.id','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.instructions','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.label','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.max','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.min','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.name','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.orientation','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.placeholder','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.readonly','false'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.requirable','false'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.size','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.step','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.tip','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.title','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.warning','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.elements.0.width','100'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.name','\"Content\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.fieldLayouts.3c2f7dee-7177-4442-957e-e9c8ed0f93a5.tabs.0.sortOrder','1'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.handle','\"userPhotos\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.hasUrls','false'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.name','\"User Photos\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.settings.path','\"@storage/userphotos\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.sortOrder','3'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.titleTranslationKeyFormat','null'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.titleTranslationMethod','\"site\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.type','\"craft\\\\volumes\\\\Local\"'),('volumes.1bf5de18-32cf-4854-ad4e-b7d9014dcf02.url','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.autocapitalize','true'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.autocomplete','false'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.autocorrect','true'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.class','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.disabled','false'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.id','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.instructions','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.label','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.max','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.min','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.name','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.orientation','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.placeholder','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.readonly','false'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.requirable','false'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.size','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.step','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.tip','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.title','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.warning','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.elements.0.width','100'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.name','\"Content\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.fieldLayouts.ab7aac97-56c9-42b8-aacf-bcff9c1ebd85.tabs.0.sortOrder','1'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.handle','\"blogImages\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.hasUrls','true'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.name','\"Blog Images\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.settings.path','\"$ASSETS_BLOG_IMAGES_PATH\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.sortOrder','2'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.titleTranslationKeyFormat','null'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.titleTranslationMethod','\"site\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.type','\"craft\\\\volumes\\\\Local\"'),('volumes.33c8318a-f8ad-43f7-8231-448c204a6ed9.url','\"$ASSETS_IMAGES_URL\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.autocapitalize','true'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.autocomplete','false'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.autocorrect','true'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.class','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.disabled','false'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.id','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.instructions','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.label','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.max','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.min','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.name','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.orientation','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.placeholder','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.readonly','false'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.requirable','false'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.size','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.step','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.tip','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.title','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.warning','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.elements.0.width','100'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.name','\"Content\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.fieldLayouts.48315f31-0ea0-44ad-a10e-31db5ffb0cf0.tabs.0.sortOrder','1'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.handle','\"podcastEpisodes\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.hasUrls','true'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.name','\"Podcast Episodes\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.settings.path','\"$ASSETS_PODCAST_EPISODE_PATH\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.sortOrder','1'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.titleTranslationKeyFormat','null'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.titleTranslationMethod','\"site\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.type','\"craft\\\\volumes\\\\Local\"'),('volumes.7c831f23-da90-4f0d-90a2-454375ee2e8e.url','\"$ASSETS_PODCAST_EPISODE_URL\"');
/*!40000 ALTER TABLE `craft_projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_queue`
--

LOCK TABLES `craft_queue` WRITE;
/*!40000 ALTER TABLE `craft_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_rackspaceaccess`
--

LOCK TABLES `craft_rackspaceaccess` WRITE;
/*!40000 ALTER TABLE `craft_rackspaceaccess` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_rackspaceaccess` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_relations` VALUES (21,6,19,NULL,14,1,'2016-06-28 22:51:09','2016-06-28 22:51:09','399510a8-40e6-43bb-9ace-0a2a1e82b57b'),(29,13,5,NULL,4,1,'2016-06-28 23:23:32','2016-06-28 23:23:32','389b1d74-8929-46aa-b63e-18f37c6e511a'),(56,2,9,NULL,22,1,'2016-06-29 03:28:18','2016-06-29 03:28:18','23820857-2f42-46d1-9baa-c721d9c76542'),(57,2,9,NULL,23,2,'2016-06-29 03:28:18','2016-06-29 03:28:18','8f7ac8ed-8c75-4b0a-b366-04d9728560cc'),(58,16,27,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','085e12ed-d945-48b6-a9dc-0f1a868243d4'),(59,2,27,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','7e3f4a38-55c2-48b2-85ed-77b2de6c8055'),(60,2,27,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','2a27c134-2694-4b5c-b7cd-94103c35b036'),(61,6,28,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','73f2750d-3cac-4ffe-a939-5c2f2db5520e'),(62,6,30,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1026465c-de00-4973-9ce4-2876364ee197'),(63,6,32,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1d3e6b29-3aa8-466e-9229-2d88a184e7e5'),(64,16,35,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','881f21cd-02b1-4647-a424-d037a6d71a53'),(65,2,35,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a385ab4c-8975-47c2-89c4-dbbcba354dfa'),(66,2,35,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','91eeae36-d389-4701-a776-f767774d197b'),(67,6,36,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','e3ae42d9-1b47-498b-b369-8f81e8a15271'),(68,6,38,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','04724fa1-f2cb-46f3-90e1-565dad7cc874'),(69,6,40,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','4fad750f-d540-4bbd-8d0b-1b17a9122da5'),(70,6,43,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','0fca0da9-b5e7-4268-9b36-b20ddd388804'),(71,6,45,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','fcf65cda-df36-478a-9af3-a5ed1cef6964'),(72,6,47,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','9b90b966-6024-4e65-b53f-02d2bfee7a8c'),(74,2,50,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','5961bf1f-1450-407e-9693-11f3547b3ac5'),(75,2,50,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','eae4706f-a7e6-4527-87e6-41e3ed931a22'),(76,6,51,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','2dae6d89-86fd-4793-9921-7c0218e7629f'),(77,6,53,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a271b165-f3e1-4ba7-8a29-a3b01dae35cd'),(78,6,55,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','164552fe-ce7f-404b-b718-6f2ff82b3494'),(79,6,58,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','bc23fdef-6065-47ca-a001-6ada6fe59103'),(80,6,60,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1a63cf2d-0148-4dae-b22b-0370b130fefa'),(81,6,62,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','4564a281-bc81-4203-89dd-5573d2a1c899'),(83,2,65,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','058f7440-8d31-4f09-bb4e-cd187799359c'),(84,2,65,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','41310b4d-8b27-46ac-bd7a-1acf4f280828'),(85,6,66,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','1d7bac8b-89cf-4c1e-bcc2-05c678421c0e'),(86,6,68,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','b18e7bf5-f5c3-4cc6-87f1-fca4ff1c2738'),(87,6,70,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','cb9e2e4f-500e-4b9a-945a-5aae0533961c'),(88,16,65,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','9cf1e990-529c-4870-b578-06a67dc9562b'),(89,6,73,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','cad55814-1866-48e2-b1ac-8d9ea3cae52c'),(90,6,75,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','0ca32a43-5910-4512-94d1-407e6519287f'),(91,6,77,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','6940a9ce-abea-46fb-98a3-0a198050b387'),(92,16,80,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','eeb2dec1-cf99-49b2-a92d-f8ad9ec056b5'),(93,2,80,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','29cd1fc4-61ce-4829-bf16-13420a209ae2'),(94,2,80,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','1ca55e23-86cf-4227-969c-eaceb3569ee7'),(95,6,81,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d584c509-e326-4b90-ad62-f9716af4bcbd'),(96,6,83,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','ee2b0433-69d5-4971-9bf4-7d48902a6e77'),(97,6,85,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','196f107f-3c7e-44a8-98f2-46bf2f5048e1'),(98,6,88,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','8fb2af7f-26f9-47d9-8026-3fd9aa884dd0'),(99,6,90,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','d8c25792-45e1-4aca-9503-2adbcc315ff8'),(100,6,92,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','a670c746-6b02-4d14-a5b7-5588f3aa2643'),(101,13,95,NULL,4,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','bc1bb15a-a246-4204-bfb7-f7bbe24f9aac'),(102,13,96,NULL,4,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','9f1c1ee9-9f2c-4673-8d3f-03c15f90e36d'),(103,13,97,NULL,4,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','b60cd787-2ca2-4bb8-b7b4-8f200993445b'),(104,16,98,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','111465a1-0e21-44f5-b777-772255171ae3'),(105,2,98,NULL,22,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','6f7beac0-5fe0-4d5f-a662-d2d9fb686261'),(106,2,98,NULL,23,2,'2021-01-18 20:27:23','2021-01-18 20:27:23','10626611-d6fb-4291-bb00-1d3e11f7872c'),(107,6,99,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','efb6bb3c-df1d-434e-92cc-7403d8192623'),(108,6,101,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','58b678d0-4cd7-4cfc-9fbf-407471eb01a0'),(109,6,103,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','23c07f9b-73a0-47ba-b818-3eb2f104f530'),(110,6,106,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','84626dfc-0e7d-4208-853a-4448d14714cc'),(111,6,108,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','24375786-ac43-4b9b-b722-4c0fabd0dd66'),(112,6,110,NULL,8,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','cb6f5834-8157-4dc6-a41f-9a6686191105'),(113,6,114,NULL,14,1,'2021-01-18 20:27:23','2021-01-18 20:27:23','13f87f6e-7abc-4155-bd0d-57b5eb22af3f'),(114,6,118,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','23feafa8-8e38-49e8-976d-62dab25d0930'),(115,16,121,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','001ff433-f741-468b-ad7d-9d6526f5cd9f'),(118,6,122,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','7027c9c6-b97a-4442-a3c6-268f41e971d7'),(119,6,124,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e52f9de4-7985-4857-9c29-d7a14726b48d'),(120,6,126,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','7d87783d-ae13-4349-8022-301e14dc7bba'),(121,6,129,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','f006244d-a359-4e8d-9dd1-e9f1df72aaac'),(122,6,131,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','bb1467b4-8c7e-40ae-a583-dd6dad52b2c6'),(123,6,133,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','07eb6d5a-0521-4225-8c76-50f1e8066dda'),(124,16,136,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ea5b3992-0ebb-43b0-8068-3bdebb879da2'),(127,6,137,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','655e0265-4e25-4f7c-80e6-87e44c9eaee5'),(128,6,139,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ac14f516-b332-491c-adb8-3ae0907164c2'),(129,6,141,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e05f8e8a-46d7-42b4-978e-f582e2ffabd8'),(130,6,144,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','8851d265-0127-46aa-ae72-47e735ea2c34'),(131,6,146,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','de4537b5-8dba-4eef-b3e0-daa52e08f78f'),(132,6,147,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','1152e3ab-03d1-4dfe-9b8c-c0cec0a0059d'),(133,16,150,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4919fe18-d965-447a-adab-11628dfdbcad'),(136,6,151,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','0a67aff8-92c0-43ed-8138-1ae297bb5311'),(137,6,153,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','c36c86c7-d5f2-4227-9887-d0369653277b'),(138,6,154,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','80872d97-1092-475e-8ca5-6477581f6efa'),(139,6,157,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','448a04f9-92dd-4777-a28c-07082048816a'),(140,6,159,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','510f610d-95b1-4b78-a024-12a64f6e32a9'),(141,6,160,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5d666dee-9f7b-496d-8dd4-35ab45916773'),(142,16,163,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e4c2f3f0-8121-407f-b846-cc1e93b49834'),(145,6,164,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5213edc6-c81b-4722-9ae7-072c97e86b0a'),(146,6,166,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','c7c3035f-de34-4f0d-9775-9f9f5bf0d920'),(147,6,167,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ea4cd09d-e764-42f1-83ec-1d15658ce30d'),(148,6,170,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e157c7fa-9a63-4a3e-a8b8-e9f127fb8ae8'),(149,6,172,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','48f66cac-1075-4f21-ba7f-51c004154f24'),(150,6,173,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','7c98a302-9df3-4ffd-9160-4178908af7d8'),(151,16,175,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','605b425c-c716-4b3e-a0f9-c6d29d5f30c1'),(154,6,176,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','5da87d40-98a2-4ec0-89d8-489e5a714275'),(155,6,178,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','ddc14a96-2b3c-4a8c-a7b5-963cf6e5d422'),(156,6,179,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','cf8191cf-1f7f-4982-8c6e-85647c99458d'),(157,6,181,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','16e51b44-bb27-4eca-9f48-8bfed4e498a2'),(158,6,183,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','61c08d6f-dff8-49f9-9451-74ad8eeeb183'),(159,16,185,NULL,14,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','4444340c-92dc-4bdc-a8ad-1f91134cfc65'),(162,6,186,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','976bc592-204b-42a1-b1fa-daddb1bfbbdf'),(163,6,188,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','a1657ee1-ef08-41a8-99f8-07c2367ab104'),(164,6,190,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','87ca06b8-92a6-44b5-9835-0c46a213089d'),(165,6,192,NULL,8,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','e070d34f-4867-44db-bc07-6bc64abea0d9'),(166,13,195,NULL,4,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','8a96e052-7eeb-420e-ac70-d2a305888ad2'),(167,13,196,NULL,4,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','f5062307-e600-481d-9b79-6128b7588179'),(168,13,197,NULL,4,1,'2021-01-18 20:27:24','2021-01-18 20:27:24','22e61c2d-3371-4a1e-8d8b-32ca5b33ae8f'),(169,16,9,NULL,200,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','b003a44b-54ea-4c76-a27b-d89c8dad96d2'),(170,6,10,NULL,200,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','265f4857-a7ad-49eb-82e8-766a6028de38'),(171,6,15,NULL,201,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','4c7298f5-b740-4cc9-a81a-f3e793e2670c'),(172,6,12,NULL,201,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','2a73093d-5f1b-47d5-9b45-8b464b1a8476'),(173,16,202,NULL,200,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','b1606feb-982c-4476-b851-e62fc3cb8b91'),(174,2,202,NULL,22,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','d1eb4943-4642-447e-a32f-0e40bab0083e'),(175,2,202,NULL,23,2,'2021-01-18 20:51:49','2021-01-18 20:51:49','d64222b5-1829-42d5-a3d6-53e258058bf8'),(176,6,203,NULL,200,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','aa00f81f-c319-4d61-9670-fa89872d77fd'),(177,6,205,NULL,201,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','04795493-3643-42b0-ab20-d0bd4262921b'),(178,6,207,NULL,201,1,'2021-01-18 20:51:49','2021-01-18 20:51:49','93a9e0f1-4a7a-4dbe-9c71-02b93d2fee16'),(179,13,210,NULL,4,1,'2021-01-18 20:58:19','2021-01-18 20:58:19','07c3e6d4-817a-4d96-aa3d-18cb3b809d41');
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_resourcepaths`
--

LOCK TABLES `craft_resourcepaths` WRITE;
/*!40000 ALTER TABLE `craft_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_resourcepaths` VALUES ('101e336b','@lib/jquery-touch-events'),('10ef45b8','@lib/velocity'),('160b2c5','@bower/jquery/dist'),('17ba0fa9','@lib/picturefill'),('191f2ff8','@lib/d3'),('1974129a','@app/web/assets/userpermissions/dist'),('1cf0339c','@app/web/assets/feed/dist'),('2298dff0','@app/web/assets/utilities/dist'),('241fb298','@craft/web/assets/dashboard/dist'),('24685786','@bower/jquery/dist'),('29c00f13','@lib/jquery.payment'),('2aa2387e','@lib/garnishjs'),('2ef01930','@lib/element-resize-detector'),('3599082e','@lib/xregexp'),('35e7a0fb','@lib/velocity'),('3f13140','@lib/iframe-resizer'),('3fe4ec40','@lib/fabric'),('3ff54ca4','@lib/selectize'),('40a7d90c','@app/web/assets/dashboard/dist'),('40e39d61','@app/web/assets/cp/dist'),('43c4222d','@lib/selectize'),('43d582c9','@lib/fabric'),('461c1dc1','@app/web/assets/updateswidget/dist'),('488eb100','@app/web/assets/craftsupport/dist'),('49a866a7','@lib/xregexp'),('4b5f3e98','@app/web/assets/fieldsettings/dist'),('54919e54','@lib/axios'),('56494ffe','@app/web/assets/updater/dist'),('569356f7','@lib/garnishjs'),('5a020035','@craft/redactor/assets/field/dist'),('5d5c9453','@craft/web/assets/feed/dist'),('5e46de1d','@lib/jquery-ui'),('61d56d5c','@app/web/assets/login/dist'),('6249a917','@craft/web/assets/craftsupport/dist'),('628a67e6','@craft/redactor/assets/redactor-plugins/dist/fullscreen'),('652e4171','@lib/d3'),('65eb7822','@app/web/assets/cp/dist'),('6a4f1eda','@craft/web/assets/login/dist'),('6b8b6120','@lib/picturefill'),('6c2f5de2','@lib/jquery-touch-events'),('71997b17','@lib/axios'),('7341aabd','@app/web/assets/updater/dist'),('736360de','@lib/fileupload'),('773d06ba','@app/web/assets/assetindexes/dist'),('78a65faf','@app/web/assets/recententries/dist'),('7903ab3','@app/web/assets/utilities/dist'),('797a3d21','@lib/vue'),('7b4e3b5e','@lib/jquery-ui'),('7fc05fc9','@lib/iframe-resizer'),('809c88e8','@lib/fabric'),('836fae13','@lib/d3'),('83aa9740','@app/web/assets/cp/dist'),('8569be45','@craft/web/assets/utilities/dist'),('8640f46e','@app/web/assets/editentry/dist'),('8794823e','@app/web/assets/login/dist'),('88e8b809','@lib/prismjs'),('8962d65a','@app/web/assets/matrix/dist'),('8a6eb280','@lib/jquery-touch-events'),('8a9fc453','@lib/velocity'),('8dca8e42','@lib/picturefill'),('95228fbc','@lib/fileupload'),('95da5cd6','@lib/garnishjs'),('96b86bbb','@lib/jquery.payment'),('9981b0ab','@lib/iframe-resizer'),('99aeb94d','@app/web/assets/dbbackup/dist'),('9b10332e','@bower/jquery/dist'),('9bb12c66','@craft/web/assets/sites/dist'),('9de0bb58','@app/web/assets/utilities/dist'),('9ee7b0cd','@app/web/assets/recententries/dist'),('a05df2a3','@app/web/assets/updateswidget/dist'),('a1811820','@app/web/assets/fields/dist'),('a5946dab','@lib/fabric'),('a6674b50','@lib/d3'),('a6e6366e','@app/web/assets/dashboard/dist'),('a77a246b','@app/web/assets/deprecationerrors/dist'),('a8c26b01','@lib/picturefill'),('ac7f5c93','@craft/web/assets/admintable/dist'),('aecf5e62','@app/web/assets/craftsupport/dist'),('af6657c3','@lib/jquery-touch-events'),('b02a6aff','@lib/fileupload'),('b0d2b995','@lib/garnishjs'),('b2d07136','@lib/axios'),('b48098db','@lib/element-resize-detector'),('b807317f','@lib/jquery-ui'),('bc8955e8','@lib/iframe-resizer'),('bca65c0e','@app/web/assets/dbbackup/dist'),('bf8fc73','@lib/element-resize-detector'),('c4365ff6','@lib/jquery-ui'),('c5e55f1e','@craft/web/assets/updateswidget/dist'),('c8b1f652','@lib/element-resize-detector'),('cc8ea50','@lib/jquery.payment'),('cd5b380f','@craft/redactor/assets/redactor-plugins/dist/video'),('ce6886bd','@app/web/assets/edituser/dist'),('cee11fbf','@lib/axios'),('cf0e2bac','@craft/redactor/assets/redactor/dist'),('d3d8e74c','@lib/xregexp'),('d6e0b6f2','@craft/web/assets/pluginstore/dist'),('d9b4a3c6','@lib/selectize'),('df9b868f','@craft/web/assets/cp/dist'),('e42d7b7d','@app/web/assets/plugins/dist'),('e7215da7','@bower/jquery/dist'),('e748fa05','@yii/debug/assets'),('e8dd48cb','@craft/feedme/web/assets/feedme/dist'),('ea890532','@lib/jquery.payment'),('ec27bf39','@lib/timepicker'),('ee12b045','@app/web/assets/editsection/dist'),('f520e57','@lib/fileupload'),('f576d7d0','@app/web/assets/clearcaches/dist'),('f6aeaada','@lib/velocity'),('f6d0020f','@lib/xregexp'),('f823f23e','@app/web/assets/admintable/dist'),('fab1dcfe','@app/web/assets/feed/dist'),('fb5f1d70','@craft/web/assets/recententries/dist'),('fcbc4685','@lib/selectize'),('ff9bf9c9','@app/web/assets/cp/dist');
/*!40000 ALTER TABLE `craft_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_revisions`
--

LOCK TABLES `craft_revisions` WRITE;
/*!40000 ALTER TABLE `craft_revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_revisions` VALUES (1,2,NULL,1,'Revision from Jun 24, 2016, 5:18:55 PM'),(2,2,NULL,2,NULL),(3,2,NULL,3,NULL),(4,9,1,12,NULL),(5,9,1,11,NULL),(6,9,1,10,NULL),(7,9,1,9,NULL),(8,9,1,8,NULL),(9,5,1,6,NULL),(10,5,1,5,NULL),(11,5,1,4,NULL),(12,9,1,7,NULL),(13,18,1,2,NULL),(14,18,1,1,NULL),(15,9,1,6,NULL),(16,9,1,5,NULL),(17,9,1,4,NULL),(18,9,1,3,NULL),(19,9,1,2,NULL),(20,9,1,1,NULL),(21,7,1,1,NULL),(22,6,1,1,NULL),(23,5,1,3,NULL),(24,5,1,2,NULL),(25,5,1,1,NULL),(26,9,1,13,''),(27,5,1,7,'');
/*!40000 ALTER TABLE `craft_revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,1,' admin '),(1,'lastname',0,1,''),(1,'firstname',0,1,''),(2,'title',0,1,' welcome to downlinkpodcast dev '),(2,'field',1,1,' it s true this site doesn t have a whole lot of content yet but don t worry our web developers have just installed the cms and they re setting things up for the content editors this very moment soon downlinkpodcast dev will be an oasis of fresh perspectives sharp analyses and astute opinions that will keep you coming back again and again '),(4,'kind',0,1,' audio '),(4,'extension',0,1,' mp3 '),(5,'field',13,1,' cms statamic '),(5,'field',11,1,' in this episode we recall our work together on the mars pathfinder mission and the sojourner rover lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(5,'title',0,1,' episode 26 looking back at pathfinder '),(5,'slug',0,1,' 26 '),(6,'field',9,1,' http google com '),(6,'field',10,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(6,'slug',0,1,' a link to a great article '),(6,'title',0,1,' a link to a great article '),(7,'field',9,1,' http mijingo com '),(7,'field',10,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat ut enim '),(7,'slug',0,1,' another link to an interesting article '),(7,'title',0,1,' another link to an interesting article '),(8,'filename',0,1,' pioneer 10 nasa flickr commons jpg '),(8,'extension',0,1,' jpg '),(8,'kind',0,1,' image '),(8,'slug',0,1,''),(8,'title',0,1,' pioneer 10 nasa flickr commons '),(9,'field',16,1,' pioneer 10 nasa flickr commons '),(9,'field',1,1,' 1983 photo of pioneer 10 nasa via flickr commons pioneer 10 nasa flickr commons full lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat pioneer missions full lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur pioneer missions left bob dole this is the quote from bob dole hi im bob dole lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur '),(9,'field',2,1,' pioneer10 retrospective '),(9,'title',0,1,' back in time pioneer 10 '),(9,'slug',0,1,' back in time pioneer 10 '),(10,'field',6,1,' pioneer 10 nasa flickr commons '),(10,'field',7,1,' 1983 photo of pioneer 10 nasa via flickr commons '),(10,'field',8,1,' full '),(10,'slug',0,1,''),(11,'field',3,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),(11,'slug',0,1,''),(12,'field',6,1,' pioneer missions '),(12,'field',7,1,''),(12,'field',8,1,' left '),(12,'slug',0,1,''),(13,'field',3,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur '),(13,'slug',0,1,''),(14,'filename',0,1,' pioneer missions jpg '),(14,'extension',0,1,' jpg '),(14,'kind',0,1,' image '),(14,'slug',0,1,''),(14,'title',0,1,' pioneer missions '),(15,'field',6,1,' pioneer missions '),(15,'field',7,1,''),(15,'field',8,1,' full '),(15,'slug',0,1,''),(16,'field',4,1,' this is the quote from bob dole hi i m bob dole '),(16,'field',5,1,' bob dole '),(16,'slug',0,1,''),(17,'field',3,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur '),(17,'slug',0,1,''),(18,'field',1,1,' pioneer missions poster nasa flickr commons pioneer missions left lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat ryan irelan mijingo lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(18,'slug',0,1,' this is a review '),(18,'title',0,1,' this is a review '),(19,'field',6,1,' pioneer missions '),(19,'field',7,1,' pioneer missions poster nasa flickr commons '),(19,'field',8,1,' left '),(19,'slug',0,1,''),(20,'field',3,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat '),(20,'slug',0,1,''),(21,'field',4,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(21,'field',5,1,' ryan irelan mijingo '),(21,'slug',0,1,''),(18,'field',14,1,' b011lsgmt2 '),(22,'name',0,1,' pioneer10 '),(22,'slug',0,1,''),(22,'title',0,1,' pioneer10 '),(23,'name',0,1,' retrospective '),(23,'slug',0,1,''),(23,'title',0,1,' retrospective '),(9,'field',15,1,' lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum '),(2,'slug',0,1,' homepage '),(198,'kind',0,1,' audio '),(198,'extension',0,1,' mp3 '),(198,'filename',0,1,' cms statamic mp3 '),(4,'slug',0,1,' cms statamic '),(4,'filename',0,1,' cms statamic mp3 '),(198,'slug',0,1,''),(198,'title',0,1,' cms statamic '),(4,'title',0,1,' cms statamic '),(199,'filename',0,1,' background stars gif '),(199,'extension',0,1,' gif '),(199,'kind',0,1,' image '),(199,'slug',0,1,''),(199,'title',0,1,' background stars '),(200,'filename',0,1,' pioneer 10 nasa flickr commons jpg '),(200,'extension',0,1,' jpg '),(200,'kind',0,1,' image '),(200,'slug',0,1,''),(200,'title',0,1,' pioneer 10 nasa flickr commons '),(201,'filename',0,1,' pioneer missions jpg '),(201,'extension',0,1,' jpg '),(201,'kind',0,1,' image '),(201,'slug',0,1,''),(201,'title',0,1,' pioneer missions '),(1,'fullname',0,1,''),(1,'email',0,1,' ryan mijingo com '),(1,'slug',0,1,'');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections` VALUES (1,NULL,'Homepage','homepage','single',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2016-06-24 17:18:55','2021-01-18 20:25:27',NULL,'b2bfca42-e66d-4231-8a3c-7245e9b49ac1'),(3,NULL,'Podcast','podcast','channel',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2016-06-24 18:35:04','2021-01-18 20:25:27',NULL,'b69d7902-4ddd-45fb-8c40-80d77d3a82eb'),(4,NULL,'Blog','blog','channel',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2016-06-24 20:17:29','2021-01-18 20:25:27',NULL,'9f8d5e5d-08f3-4e6e-bb6b-0e0e63deae34'),(6,NULL,'Review','review','channel',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2016-06-27 19:20:18','2021-01-18 20:25:27',NULL,'0464fede-3a5f-4c7d-9de1-c1b8021eaa8d');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections_sites`
--

LOCK TABLES `craft_sections_sites` WRITE;
/*!40000 ALTER TABLE `craft_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections_sites` VALUES (1,1,1,1,1,'__home__','index','2016-06-24 17:18:55','2016-06-24 17:18:55','1af91287-9e37-427d-875d-73520b6db5a5'),(3,3,1,1,1,'podcast/{slug}','entry','2016-06-24 18:35:04','2016-06-24 18:35:04','2eee8e0b-6463-4051-8ebf-087b7cfa9d3f'),(4,4,1,1,1,'blog/{postDate|date(\"Y\")}/{postDate|date(\"m\")}/{slug}','entry','2016-06-24 20:17:29','2016-06-26 01:58:56','84bd0733-f520-43a9-9f35-5df4ed45c375'),(6,6,1,1,1,'review/{slug}','entry','2016-06-27 19:20:18','2016-06-27 19:23:19','413ffcc9-962a-404e-aaa4-7aa2ebe5d6eb');
/*!40000 ALTER TABLE `craft_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sequences`
--

LOCK TABLES `craft_sequences` WRITE;
/*!40000 ALTER TABLE `craft_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sitegroups`
--

LOCK TABLES `craft_sitegroups` WRITE;
/*!40000 ALTER TABLE `craft_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sitegroups` VALUES (1,'Downlink (en-US)','2021-01-18 20:25:25','2021-01-18 20:25:25',NULL,'8d76cad1-25d8-4b50-8cae-e68b02cac669');
/*!40000 ALTER TABLE `craft_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sites`
--

LOCK TABLES `craft_sites` WRITE;
/*!40000 ALTER TABLE `craft_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sites` VALUES (1,1,1,1,'Downlink (en-US)','en_us','en-US',1,'$BASE_URL',1,'2021-01-18 20:25:23','2021-01-18 20:31:25',NULL,'35c13b6c-aaee-499a-9580-96963583b7f4');
/*!40000 ALTER TABLE `craft_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_systemmessages`
--

LOCK TABLES `craft_systemmessages` WRITE;
/*!40000 ALTER TABLE `craft_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_taggroups` VALUES (1,'Default','default',1,'2016-06-24 17:18:55','2016-06-24 17:18:55',NULL,'237da2ff-504f-4e2c-bf6c-152bf831c8f1');
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_tags` VALUES (22,1,NULL,'2016-06-28 22:58:18','2016-06-28 22:58:18','2afbd1ff-1f81-4748-bbe7-b290cc5b9751'),(23,1,NULL,'2016-06-28 22:58:22','2016-06-28 22:58:22','c74ea2f7-00e9-4de1-bfc9-544683f1c44b');
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpermissions` VALUES (1,'editimagesinvolume:1bf5de18-32cf-4854-ad4e-b7d9014dcf02','2021-01-18 20:25:27','2021-01-18 20:25:27','ced7b83e-0e49-4140-877e-831162a99b23'),(2,'editimagesinvolume:33c8318a-f8ad-43f7-8231-448c204a6ed9','2021-01-18 20:25:27','2021-01-18 20:25:27','25adf37a-5891-413e-8c96-b3597037cb91'),(3,'editimagesinvolume:7c831f23-da90-4f0d-90a2-454375ee2e8e','2021-01-18 20:25:27','2021-01-18 20:25:27','bc673c67-0e1b-4145-a1cf-340f15be3b50');
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpreferences`
--

LOCK TABLES `craft_userpreferences` WRITE;
/*!40000 ALTER TABLE `craft_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpreferences` VALUES (1,'{\"language\":\"en-US\",\"locale\":null,\"weekStartDay\":\"1\",\"useShapes\":false,\"underlineLinks\":false,\"showFieldHandles\":false,\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true,\"showExceptionView\":false,\"profileTemplates\":false}');
/*!40000 ALTER TABLE `craft_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_users` VALUES (1,'admin',NULL,'','','ryan@mijingo.com','$2y$13$iSZe0RFvFUQ8WicLPBTT7.SkoihezDC3OrkNJlrGT.421iRKYWeUK',1,0,0,0,'2021-03-02 19:37:19','::1',NULL,NULL,'2016-06-27 02:41:49',NULL,1,NULL,NULL,NULL,0,'2016-06-24 17:18:51','2016-06-24 17:18:51','2021-03-02 19:37:19','09b72581-12ac-4385-b188-697d1e9a4137');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumefolders`
--

LOCK TABLES `craft_volumefolders` WRITE;
/*!40000 ALTER TABLE `craft_volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_volumefolders` VALUES (1,NULL,1,'Podcast Episodes','','2016-06-25 01:58:09','2016-06-25 01:58:09','bc815219-e951-42c8-8c28-738e66983530'),(2,NULL,2,'Blog Images','','2016-06-25 02:14:14','2016-06-25 02:14:14','4c976f14-ed54-4ce1-a48a-4d25a434e361'),(3,NULL,3,'User Photos',NULL,'2021-01-18 20:25:23','2021-01-18 20:25:23','e2d82976-aec4-4069-bf56-6e9bc991c6aa'),(4,NULL,NULL,'Temporary source',NULL,'2021-01-18 20:27:36','2021-01-18 20:27:36','0d83b7f7-195a-42e3-9fed-fa76232e3629'),(5,4,NULL,'user_1','user_1/','2021-01-18 20:27:36','2021-01-18 20:27:36','e8bcd0b1-122a-471a-a6b8-53ee45bbce9c');
/*!40000 ALTER TABLE `craft_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumes`
--

LOCK TABLES `craft_volumes` WRITE;
/*!40000 ALTER TABLE `craft_volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_volumes` VALUES (1,'Podcast Episodes','podcastEpisodes','craft\\volumes\\Local',1,'$ASSETS_PODCAST_EPISODE_URL','site',NULL,'{\"path\":\"$ASSETS_PODCAST_EPISODE_PATH\"}',1,20,'2016-06-25 01:58:09','2021-01-18 20:41:45',NULL,'7c831f23-da90-4f0d-90a2-454375ee2e8e'),(2,'Blog Images','blogImages','craft\\volumes\\Local',1,'$ASSETS_IMAGES_URL','site',NULL,'{\"path\":\"$ASSETS_BLOG_IMAGES_PATH\"}',2,22,'2016-06-25 02:14:14','2021-01-18 20:43:53',NULL,'33c8318a-f8ad-43f7-8231-448c204a6ed9'),(3,'User Photos','userPhotos','craft\\volumes\\Local',0,NULL,'site',NULL,'{\"path\":\"@storage/userphotos\"}',3,31,'2021-01-18 20:25:23','2021-03-02 19:47:51',NULL,'1bf5de18-32cf-4854-ad4e-b7d9014dcf02');
/*!40000 ALTER TABLE `craft_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,NULL,'2016-06-24 17:19:08','2016-06-24 17:19:08','6e3e6757-2f36-476c-b452-03f903cbed6b'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,NULL,'2016-06-24 17:19:08','2021-01-18 20:25:24','712022d4-10c1-4e49-9711-d3bd0b9db1da'),(3,1,'craft\\widgets\\Updates',3,NULL,NULL,'2016-06-24 17:19:08','2016-06-24 17:19:08','834d43f0-e428-41be-aaae-711579b355a3'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https:\\/\\/craftcms.com\\/news.rss\",\"title\":\"Craft News\"}','2016-06-24 17:19:08','2016-06-24 17:19:08','41e63933-2cb7-44bc-aafd-2907f111bd51');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'myfirstmodule'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-02 20:03:40
