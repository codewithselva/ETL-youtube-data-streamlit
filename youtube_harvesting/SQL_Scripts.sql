--Channel - table creation

CREATE TABLE `youtube_harvesting`.`channel` (
`channel_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the channel' , 
`channel_name` VARCHAR(255) NOT NULL COMMENT 'Name of the channel' , 
`channel_type` VARCHAR(255) NOT NULL COMMENT 'Type of the channel' , 
`channel_views` INT NOT NULL COMMENT 'Total number of views for the channel' , 
`channel_description` TEXT NOT NULL COMMENT 'Description of the channel' , 
`channel_status` VARCHAR(255) NOT NULL COMMENT 'Status of the channel' ,
PRIMARY KEY (channel_id),
) ENGINE = InnoDB 
COMMENT = 'Contains the information about the channel';


--playlist - table creation
CREATE TABLE `youtube_harvesting`.`playlist` (
`playlist_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the playlist' , 
`channel_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the channel table' , 
`playlist_name` VARCHAR(255) NOT NULL COMMENT 'Name of the playlist' ,
PRIMARY KEY (playlist_id),
FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
) ENGINE = InnoDB 
COMMENT = 'Contains the information about the playlists';

--video - table creation
CREATE TABLE `youtube_harvesting`.`video` (
`video_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the video' , 
`playlist_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the playlist table' , 
`video_name` VARCHAR(255) NOT NULL COMMENT 'Name of the video' , 
`video_description` TEXT NOT NULL COMMENT 'Description of the video' , 
`published_date` DATETIME NOT NULL COMMENT 'Date and time when the video was published' , 
`view_count` INT NOT NULL COMMENT 'Total number of views for the video' , 
`like_count` INT NOT NULL COMMENT 'Total number of likes for the video' , 
`dislike_count` INT NOT NULL COMMENT 'Total number of dislikes for the video' , 
`favorite_count` INT NOT NULL COMMENT 'Total number of times sthe video has been marked as a favorite' , 
`comment_count` INT NOT NULL COMMENT 'Total number of comments on the video' , 
`duration` INT NOT NULL COMMENT 'Duration of video in seconds' , 
`thumbnail` VARCHAR(255) NOT NULL COMMENT 'URL of the thumbnail for the video' , 
`caption_status` VARCHAR(255) NOT NULL COMMENT 'Status of the video caption' ,
PRIMARY KEY (video_id),
FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id)
) ENGINE = InnoDB COMMENT = 'Contains information about the video';


--comment - table creation
CREATE TABLE `youtube_harvesting`.`comment` (
`comment_id` VARCHAR(255) NOT NULL COMMENT 'Unique identifier for the comment' , 
`video_id` VARCHAR(255) NOT NULL COMMENT 'Foreign key referencing the video table' , 
`comment_text` TEXT NOT NULL COMMENT 'Text of the comment' , 
`comment_author` VARCHAR(255) NOT NULL COMMENT 'Name of the comment author' , 
`comment_published_date` DATETIME NOT NULL COMMENT 'Date and time when the comment was published' , 
PRIMARY KEY (comment_id),
FOREIGN KEY (video_id) REFERENCES video(video_id)
) ENGINE = InnoDB COMMENT = 'Contains information about the comment';