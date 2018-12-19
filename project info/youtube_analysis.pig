


youtube_data = load 'youtubedata.txt' using PigStorage('\t')
as
(
video_id: chararray,
video_string: chararray,
interval: int,
category: chararray,
length: int,
views: int,
rating: float,
no_of_rating: float,
no_of_comments: int,
related_video_id: chararray
);


############################ 1 #############################

video_group_category = group youtube_data by category ;

dump video_group_category;

total_video_by_category = foreach video_group_category generate COUNT(youtube_data.video_id) as total_video, youtube_data.category;

dump total_video_by_category;
  
sorted_total_video_by_category = order total_video_by_category by total_video desc;

max_video_by_category = LIMIT sorted_total_video_by_category 5;

dump max_video_by_category;

store max_video_by_category into 'youtube_analysis/youtube1' using PigStorage('\t','-schema');

############################ 2 ################################


sorted_rating_video = order youtube_data by rating desc;

dump sorted_rating_video;

sorted_rating_video_list = foreach sorted_rating_video generate video_id, video_string, rating, category ; 

top_rated_video = LIMIT sorted_rating_video_list 10;

dump top_rated_video; 

store top_rated_video into 'youtube_analysis/youtube2' using PigStorage('\t','-schema');


############################ 3 ################################

sorted_viwed_video = order youtube_data by views desc;

dump sorted_viwed_video;

sorted_viwed_video_list = foreach sorted_viwed_video generate video_id, video_string, rating, category, views ; 

top_viwed_video = LIMIT sorted_viwed_video_list 10;

dump top_viwed_video; 


store top_viwed_video into 'youtube_analysis/youtube3' using PigStorage('\t','-schema');




