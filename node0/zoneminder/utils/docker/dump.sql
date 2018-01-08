-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: zm
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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

DROP TABLE IF EXISTS `Monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitors` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `ServerId` int(10) unsigned DEFAULT NULL,
  `Type` enum('Local','Remote','File','Ffmpeg','Libvlc','cURL') NOT NULL DEFAULT 'Local',
  `Function` enum('None','Monitor','Modect','Record','Mocord','Nodect') NOT NULL DEFAULT 'Monitor',
  `Enabled` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `LinkedMonitors` varchar(255) DEFAULT NULL,
  `Triggers` set('X10') NOT NULL DEFAULT '',
  `Device` tinytext NOT NULL,
  `Channel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Format` int(10) unsigned NOT NULL DEFAULT '0',
  `V4LMultiBuffer` tinyint(1) unsigned DEFAULT NULL,
  `V4LCapturesPerFrame` tinyint(3) unsigned DEFAULT NULL,
  `Protocol` varchar(16) DEFAULT '',
  `Method` varchar(16) NOT NULL DEFAULT '',
  `Host` varchar(64) DEFAULT NULL,
  `Port` varchar(8) NOT NULL DEFAULT '',
  `SubPath` varchar(64) NOT NULL DEFAULT '',
  `Path` varchar(255) DEFAULT NULL,
  `Options` varchar(255) DEFAULT '',
  `User` varchar(64) DEFAULT NULL,
  `Pass` varchar(64) DEFAULT NULL,
  `Width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Colours` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Palette` int(10) unsigned NOT NULL DEFAULT '0',
  `Orientation` enum('0','90','180','270','hori','vert') NOT NULL DEFAULT '0',
  `Deinterlacing` int(10) unsigned NOT NULL DEFAULT '0',
  `SaveJPEGs` tinyint(4) NOT NULL DEFAULT '3',
  `VideoWriter` tinyint(4) NOT NULL DEFAULT '0',
  `EncoderParameters` text,
  `RecordAudio` tinyint(4) NOT NULL DEFAULT '0',
  `RTSPDescribe` tinyint(1) unsigned DEFAULT NULL,
  `Brightness` mediumint(7) NOT NULL DEFAULT '-1',
  `Contrast` mediumint(7) NOT NULL DEFAULT '-1',
  `Hue` mediumint(7) NOT NULL DEFAULT '-1',
  `Colour` mediumint(7) NOT NULL DEFAULT '-1',
  `EventPrefix` varchar(32) NOT NULL DEFAULT 'Event-',
  `LabelFormat` varchar(64) DEFAULT NULL,
  `LabelX` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LabelY` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LabelSize` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ImageBufferCount` smallint(5) unsigned NOT NULL DEFAULT '100',
  `WarmupCount` smallint(5) unsigned NOT NULL DEFAULT '25',
  `PreEventCount` smallint(5) unsigned NOT NULL DEFAULT '10',
  `PostEventCount` smallint(5) unsigned NOT NULL DEFAULT '10',
  `StreamReplayBuffer` int(10) unsigned NOT NULL DEFAULT '1000',
  `AlarmFrameCount` smallint(5) unsigned NOT NULL DEFAULT '1',
  `SectionLength` int(10) unsigned NOT NULL DEFAULT '600',
  `FrameSkip` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MotionFrameSkip` smallint(5) unsigned NOT NULL DEFAULT '0',
  `AnalysisFPS` decimal(5,2) DEFAULT NULL,
  `AnalysisUpdateDelay` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxFPS` decimal(5,2) DEFAULT NULL,
  `AlarmMaxFPS` decimal(5,2) DEFAULT NULL,
  `FPSReportInterval` smallint(5) unsigned NOT NULL DEFAULT '250',
  `RefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT '6',
  `AlarmRefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT '6',
  `Controllable` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ControlId` int(10) unsigned DEFAULT NULL,
  `ControlDevice` varchar(255) DEFAULT NULL,
  `ControlAddress` varchar(255) DEFAULT NULL,
  `AutoStopTimeout` decimal(5,2) DEFAULT NULL,
  `TrackMotion` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `TrackDelay` smallint(5) unsigned DEFAULT NULL,
  `ReturnLocation` tinyint(3) NOT NULL DEFAULT '-1',
  `ReturnDelay` smallint(5) unsigned DEFAULT NULL,
  `DefaultView` enum('Events','Control') NOT NULL DEFAULT 'Events',
  `DefaultRate` smallint(5) unsigned NOT NULL DEFAULT '100',
  `DefaultScale` smallint(5) unsigned NOT NULL DEFAULT '100',
  `SignalCheckColour` varchar(32) NOT NULL DEFAULT '#0000BE',
  `WebColour` varchar(32) NOT NULL DEFAULT 'red',
  `Exif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `Sequence` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitors`
--

LOCK TABLES `Monitors` WRITE;
/*!40000 ALTER TABLE `Monitors` DISABLE KEYS */;
INSERT INTO `Monitors` VALUES (3,'Italy - Milano trafic',NULL,'Ffmpeg','Modect',0,NULL,'','/dev/video0',0,255,NULL,1,'rtsp','rtpRtsp','92.223.183.218','8082','','http://92.223.183.218:8082/mjpg/video.mjpg',NULL,NULL,NULL,640,480,3,0,'0',0,3,0,'# Lines beginning with # are a comment \r\n# For changing quality, use the crf option\r\n# 1 is best, 51 is worst quality\r\n#crf=23',0,0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,1,50,25,25,25,1000,1,600,0,0,NULL,0,NULL,NULL,1000,6,6,0,NULL,NULL,NULL,NULL,0,NULL,-1,NULL,'Events',100,100,'#0000c0','green',0,1),(4,'France - Bordeau Laundry',NULL,'Ffmpeg','Modect',0,NULL,'','/dev/video0',0,255,NULL,1,'http','rtpRtsp','83.155.186.129','8084','','http://83.155.186.129:8084/mjpg/video.mjpg',NULL,NULL,NULL,320,240,3,0,'0',0,3,0,'# Lines beginning with # are a comment \r\n# For changing quality, use the crf option\r\n# 1 is best, 51 is worst quality\r\n#crf=23',0,0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,1,50,25,25,25,1000,1,600,0,0,NULL,0,NULL,NULL,1000,6,6,0,NULL,NULL,NULL,NULL,0,NULL,-1,NULL,'Events',100,100,'#0000c0','red',0,2),(5,'US Reception area',NULL,'Remote','Modect',0,NULL,'','/dev/video0',0,255,NULL,1,'http','simple','66.135.243.108','80','','/axis-cgi/mjpg/video.cgi?camera=&resolution=320x240',NULL,NULL,NULL,320,240,3,0,'0',0,3,0,'# Lines beginning with # are a comment \r\n# For changing quality, use the crf option\r\n# 1 is best, 51 is worst quality\r\n#crf=23',0,NULL,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,1,50,25,25,25,1000,1,600,0,0,NULL,0,NULL,NULL,1000,6,6,0,NULL,NULL,NULL,NULL,0,NULL,-1,NULL,'Events',100,100,'#0000c0','yellow',0,3),(8,'US - Main entrance',NULL,'Ffmpeg','Modect',0,NULL,'','/dev/video0',0,255,NULL,1,NULL,'rtpRtsp',NULL,'80','','http://108.176.59.122:91/mjpg/video.mjpg',NULL,NULL,NULL,320,240,3,0,'0',0,3,0,'# Lines beginning with # are a comment \r\n# For changing quality, use the crf option\r\n# 1 is best, 51 is worst quality\r\n#crf=23',0,0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,1,50,25,25,25,1000,1,600,0,0,NULL,0,NULL,NULL,1000,6,6,0,NULL,NULL,NULL,NULL,0,NULL,-1,NULL,'Events',100,100,'#0000c0','cyan',0,4),(9,'US - mailbox',NULL,'Ffmpeg','Modect',0,NULL,'','/dev/video0',0,255,0,1,NULL,'rtpRtsp',NULL,'80','','http://108.176.59.122:90/mjpg/video.mjpg',NULL,NULL,NULL,320,240,3,0,'0',0,3,0,'# Lines beginning with # are a comment \r\n# For changing quality, use the crf option\r\n# 1 is best, 51 is worst quality\r\n#crf=23',0,0,-1,-1,-1,-1,'Event-','%N - %d/%m/%y %H:%M:%S',0,0,1,50,25,25,25,1000,1,600,0,0,NULL,0,NULL,NULL,1000,6,6,0,NULL,NULL,NULL,NULL,0,NULL,-1,NULL,'Events',100,100,'#0000c0','blue',0,5);
/*!40000 ALTER TABLE `Monitors` ENABLE KEYS */;
UNLOCK TABLES;
