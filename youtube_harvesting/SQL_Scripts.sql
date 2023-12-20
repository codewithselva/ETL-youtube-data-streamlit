-- CREATE  DATABASE youtube_harvesting;

-- Channel - table creation

CREATE TABLE `youtube_harvesting`.`channel` (
`channel_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the channel' , 
`channel_name` VARCHAR(255) NOT NULL COMMENT 'Name of the channel' , 
`channel_type` VARCHAR(255) NOT NULL COMMENT 'Type of the channel' , 
`channel_views` INT  COMMENT 'Total number of views for the channel' , 
`channel_description` TEXT NULL COMMENT 'Description of the channel' , 
`channel_status` VARCHAR(255) NOT NULL COMMENT 'Status of the channel' ,
`channel_video_count` INT COMMENT 'Total number of videos for the channel',
PRIMARY KEY (channel_id)
) ENGINE = InnoDB 
COMMENT = 'Contains the information about the channel';


-- playlist - table creation
CREATE TABLE `youtube_harvesting`.`playlist` (
`playlist_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the playlist' , 
`channel_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the channel table' , 
`playlist_name` VARCHAR(255) NOT NULL COMMENT 'Name of the playlist' ,
PRIMARY KEY (playlist_id),
FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
) ENGINE = InnoDB 
COMMENT = 'Contains the information about the playlists';

-- video - table creation

CREATE TABLE `youtube_harvesting`.`videos` (
`video_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the video' , 
`playlist_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the playlist table' , 
`video_name` VARCHAR(255) NOT NULL COMMENT 'Name of the video' , 
`video_description` TEXT NULL COMMENT 'Description of the video' , 
`published_date` DATETIME NOT NULL COMMENT 'Date and time when the video was published' , 
`view_count` INT  COMMENT 'Total number of views for the video' , 
`like_count` INT  COMMENT 'Total number of likes for the video' , 
`dislike_count` INT COMMENT 'Total number of dislikes for the video' , 
`favorite_count` INT  COMMENT 'Total number of times the video has been marked as a favorite' , 
`comment_count` INT  COMMENT 'Total number of comments on the video' , 
`duration` INT  COMMENT 'Duration of video in seconds' , 
`thumbnail` VARCHAR(255) NOT NULL COMMENT 'URL of the thumbnail for the video' , 
`caption_status` VARCHAR(255) NOT NULL COMMENT 'Status of the video caption' ,
PRIMARY KEY (video_id),
FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id)
) ENGINE = InnoDB COMMENT = 'Contains information about the video';

CREATE TABLE `youtube_harvesting`.`comment` (
`comment_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the comment' , 
`video_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the video table' , 
`comment_text` TEXT NOT NULL COMMENT 'Text of the comment' , 
`comment_author` VARCHAR(255) NOT NULL COMMENT 'Name of the comment author' , 
`comment_published_date` DATETIME NOT NULL COMMENT 'Date and time when the comment was published' , 
PRIMARY KEY (comment_id),
FOREIGN KEY (video_id) REFERENCES videos(video_id)
) ENGINE = InnoDB COMMENT = 'Contains information about the comment';


CREATE TABLE `youtube_harvesting`.`questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `query` TEXT NOT NULL,
  PRIMARY KEY (`id`))
COMMENT = 'Contains the list of questions and its query';

INSERT INTO `youtube_harvesting`.`questions`
(`name`,
`query`)
VALUES
("What are the names of all the videos and their corresponding channels?",
"select video_name, channel_name from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id order by channel_name "),

("Which channels have the most number of videos, and how many videos do  they have?",
"select c.channel_name , c.channel_video_count from channel c where c.channel_video_count = (select max(c1.channel_video_count) from channel c1)"),

("What are the top 10 most viewed videos and their respective channels?",
"select video_name, channel_name, view_count from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id order by view_count desc limit 10"),

("How many comments were made on each video, and what are their  corresponding video names?",
"select video_name , count(com.comment_id) number_of_comments from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id left join comment com on com.video_id=v.video_id group by video_name order by number_of_comments desc"),

("Which videos have the highest number of likes, and what are their  corresponding channel names?",
"SELECT     v.video_name,     c.channel_name,     v.like_count FROM     videos v JOIN playlist pl ON v.playlist_id = pl.playlist_id JOIN channel c ON pl.channel_id = c.channel_id WHERE     v.like_count = (SELECT MAX(like_count) FROM videos)"),

("What is the total number of likes and dislikes for each video, and what are  their corresponding video names?",
"SELECT video_name , (like_count+dislike_count) like_dislike_sum FROM youtube_harvesting.videos"),

("What is the total number of views for each channel, and what are their  corresponding channel names?",
"SELECT channel_name,channel_views FROM youtube_harvesting.channel"),

("What are the names of all the channels that have published videos in the year  2022?",
"select distinct channel_name from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id where YEAR(v.published_date)=2022"),

("What is the average duration of all videos in each channel, and what are their  corresponding channel names?",
"select  channel_name , avg(duration) average_duration from channel c left join playlist pl  on c.channel_id = pl.channel_id left join videos v on v.playlist_id = pl.playlist_id group by channel_name"),

("Which videos have the highest number of comments, and what are their  corresponding channel names?",
"SELECT     v.video_name,    c.channel_name,    COUNT(co.comment_id) AS comment_count FROM     videos v JOIN playlist pl ON v.playlist_id = pl.playlist_id JOIN channel c ON pl.channel_id = c.channel_id LEFT JOIN comment co ON v.video_id = co.video_id GROUP BY     v.video_id, c.channel_id ORDER BY     comment_count DESC LIMIT 1")
;