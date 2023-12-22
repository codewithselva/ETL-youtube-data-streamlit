CREATE DATABASE  IF NOT EXISTS `youtube_harvesting` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `youtube_harvesting`;
-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: youtube_harvesting
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `channel`
--

DROP TABLE IF EXISTS `channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel` (
  `channel_id` varchar(255) NOT NULL COMMENT 'Unique identifier for the channel',
  `channel_name` varchar(255) NOT NULL COMMENT 'Name of the channel',
  `channel_type` varchar(255) NOT NULL COMMENT 'Type of the channel',
  `channel_views` bigint DEFAULT NULL COMMENT 'Total number of views for the channel',
  `channel_description` text COMMENT 'Description of the channel',
  `channel_status` varchar(255) DEFAULT NULL COMMENT 'Status of the channel',
  `channel_video_count` int DEFAULT NULL COMMENT 'Total number of videos for the channel',
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contains the information about the channel';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` varchar(255) NOT NULL COMMENT 'Unique identifier for the comment',
  `video_id` varchar(255) NOT NULL COMMENT 'Foreign key referencing the video table',
  `comment_text` text NOT NULL COMMENT 'Text of the comment',
  `comment_author` varchar(255) NOT NULL COMMENT 'Name of the comment author',
  `comment_published_date` datetime NOT NULL COMMENT 'Date and time when the comment was published',
  PRIMARY KEY (`comment_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contains information about the comment';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `playlist_id` varchar(255) NOT NULL COMMENT 'Unique identifier for the playlist',
  `channel_id` varchar(255) NOT NULL COMMENT 'Foreign key referencing the channel table',
  `playlist_name` varchar(255) NOT NULL COMMENT 'Name of the playlist',
  PRIMARY KEY (`playlist_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contains the information about the playlists';
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `query` text NOT NULL,
  `channel_filter` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contains the list of questions and its query';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'What are the names of all the videos and their corresponding channels?','select video_name, channel_name from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id order by channel_name ',0),(2,'Which channels have the most number of videos, and how many videos do  they have?','select c.channel_name , c.channel_video_count from channel c where c.channel_video_count = (select max(c1.channel_video_count) from channel c1)',0),(3,'What are the top 10 most viewed videos and their respective channels?','select video_name, channel_name, view_count from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id order by view_count desc limit 10',0),(4,'How many comments were made on each video, and what are their  corresponding video names?','select video_name , count(com.comment_id) number_of_comments from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id left join comment com on com.video_id=v.video_id group by video_name order by number_of_comments desc',0),(5,'Which videos have the highest number of likes, and what are their  corresponding channel names?','SELECT     v.video_name,     c.channel_name,     v.like_count FROM     videos v JOIN playlist pl ON v.playlist_id = pl.playlist_id JOIN channel c ON pl.channel_id = c.channel_id WHERE     v.like_count = (SELECT MAX(like_count) FROM videos)',0),(6,'What is the total number of likes and dislikes for each video, and what are  their corresponding video names?','SELECT video_name , (IFNULL(like_count, 0) + IFNULL(dislike_count, 0))  like_dislike_sum FROM youtube_harvesting.videos',0),(7,'What is the total number of views for each channel, and what are their  corresponding channel names?','SELECT channel_name,channel_views FROM youtube_harvesting.channel',0),(8,'What are the names of all the channels that have published videos in the year  2022?','select distinct channel_name from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id where YEAR(v.published_date)=2022',0),(9,'What is the average duration of all videos in each channel, and what are their  corresponding channel names?','select  channel_name , avg(duration) average_duration from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id group by channel_name',0),(10,'Which videos have the highest number of comments, and what are their  corresponding channel names?','SELECT     v.video_name,    c.channel_name,    COUNT(co.comment_id) AS comment_count FROM     videos v JOIN playlist pl ON v.playlist_id = pl.playlist_id JOIN channel c ON pl.channel_id = c.channel_id LEFT JOIN comment co ON v.video_id = co.video_id GROUP BY     v.video_id, c.channel_id ORDER BY     comment_count DESC LIMIT 1',0),(11,'What are the names of all the videos and their corresponding channels?','SELECT     video_name, channel_name FROM    channel c        INNER JOIN    playlist pl ON c.channel_id = pl.channel_id        INNER JOIN    videos v ON v.playlist_id = pl.playlist_id    where    c.channel_id in (\'{channel_id}\') ',1),(12,'Which channels have the most number of videos, and how many videos do  they have?','SELECT     c.channel_name, c.channel_video_count FROM     channel c WHERE	c.channel_id in (\'{channel_id}\') and    c.channel_video_count = (SELECT             MAX(c1.channel_video_count)        FROM            channel c1 where c1.channel_id = c.channel_id)',1),(13,'What are the top 10 most viewed videos and their respective channels?','SELECT     video_name, channel_name, view_count FROM    channel c        LEFT JOIN    playlist pl ON c.channel_id = pl.channel_id        LEFT JOIN    videos v ON v.playlist_id = pl.playlist_id    where c.channel_id in (\'{channel_id}\') ORDER BY view_count DESC LIMIT 10',1),(14,'How many comments were made on each video, and what are their  corresponding video names?','SELECT     video_name, COUNT(com.comment_id) number_of_comments FROM     channel c        LEFT JOIN    playlist pl ON c.channel_id = pl.channel_id        LEFT JOIN    videos v ON v.playlist_id = pl.playlist_id        LEFT JOIN    comment com ON com.video_id = v.video_id    where c.channel_id in (\'{channel_id}\') GROUP BY video_name ORDER BY number_of_comments DESC',1),(15,'Which videos have the highest number of likes, and what are their  corresponding channel names?','SELECT     v.video_name, c.channel_name, v.like_count FROM    videos v        JOIN    playlist pl ON v.playlist_id = pl.playlist_id        JOIN    channel c ON pl.channel_id = c.channel_id WHERE c.channel_id in (\'{channel_id}\') and    v.like_count = (SELECT             MAX(like_count)        FROM            videos)',1),(16,'What is the total number of likes and dislikes for each video, and what are  their corresponding video names?','SELECT c.channel_name,    video_name,    (IFNULL(like_count, 0) + IFNULL(dislike_count, 0)) like_dislike_sum FROM    channel c    INNER JOIN   playlist pl ON c.channel_id = pl.channel_id   INNER JOIN    videos v ON v.playlist_id = pl.playlist_id WHERE c.channel_id IN (\'{channel_id}\')',1),(17,'What is the total number of views for each channel, and what are their  corresponding channel names?','SELECT     channel_name, channel_views FROM    youtube_harvesting.channel  c  where c.channel_id in (\'{channel_id}\')',1),(18,'What are the names of all the channels that have published videos in the year  2022?','SELECT DISTINCT    channel_name FROM    channel c        LEFT JOIN    playlist pl ON c.channel_id = pl.channel_id        LEFT JOIN    videos v ON v.playlist_id = pl.playlist_id WHERE    YEAR(v.published_date) = 2022    and c.channel_id in (\'{channel_id}\')',1),(19,'What is the average duration of all videos in each channel, and what are their  corresponding channel names?','SELECT     channel_name, AVG(duration) average_duration FROM    channel c        LEFT JOIN    playlist pl ON c.channel_id = pl.channel_id        LEFT JOIN    videos v ON v.playlist_id = pl.playlist_id    where c.channel_id in (\'{channel_id}\') GROUP BY channel_name',1),(20,'Which videos have the highest number of comments, and what are their  corresponding channel names?','SELECT     v.video_name,    c.channel_name,    COUNT(co.comment_id) AS comment_count FROM    videos v        JOIN    playlist pl ON v.playlist_id = pl.playlist_id        JOIN    channel c ON pl.channel_id = c.channel_id        LEFT JOIN    comment co ON v.video_id = co.video_id    where c.channel_id in (\'{channel_id}\') GROUP BY v.video_id , c.channel_id ORDER BY comment_count DESC LIMIT 1',1);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `video_id` varchar(255) NOT NULL COMMENT 'Unique identifier for the video',
  `playlist_id` varchar(255) NOT NULL COMMENT 'Foreign key referencing the playlist table',
  `video_name` varchar(255) NOT NULL COMMENT 'Name of the video',
  `video_description` text COMMENT 'Description of the video',
  `published_date` datetime NOT NULL COMMENT 'Date and time when the video was published',
  `view_count` int DEFAULT NULL COMMENT 'Total number of views for the video',
  `like_count` int DEFAULT NULL COMMENT 'Total number of likes for the video',
  `dislike_count` int DEFAULT NULL COMMENT 'Total number of dislikes for the video',
  `favorite_count` int DEFAULT NULL COMMENT 'Total number of times the video has been marked as a favorite',
  `comment_count` int DEFAULT NULL COMMENT 'Total number of comments on the video',
  `duration` int DEFAULT NULL COMMENT 'Duration of video in seconds',
  `thumbnail` varchar(255) NOT NULL COMMENT 'URL of the thumbnail for the video',
  `caption_status` varchar(255) DEFAULT NULL COMMENT 'Status of the video caption',
  PRIMARY KEY (`video_id`),
  KEY `playlist_id` (`playlist_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Contains information about the video';
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-22 15:32:38
