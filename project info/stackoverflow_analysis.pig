

comments_data = load 'comments.csv' using PigStorage(',')
as
(
comment_id: int,
comment_userid: int
);


###########################################################

posts_data = load 'posts.csv' using PigStorage(',')
as
(
post_id: int,
post_type: int,
creationdate: datetime,
score: int,
viewcount: int,
owneruserid: int,
title: chararray,
answercount: int,
commentcount: int
);


###############################################################

post_types_data = load 'posttypes.csv' using PigStorage(',')
as
(
post_types_id: int,
post_types_name: chararray
);

################################################################

users_data = load 'users.csv' using PigStorage(',')
as
(
user_id: int,
reputation: int,
displayname: chararray,
loc: chararray,
age: int
);

###############################################################


A) 


user_post_data = join users_data by user_id, posts_data by owneruserid ;

group_post_by_user = group user_post_data by owneruserid ;

total_user_post = foreach group_post_by_user generate COUNT(user_post_data.owneruserid) as total_post, user_post_data.displayname ,user_post_data.reputation ;

sorted_total_user_post = order total_user_post by user_post_data.reputation desc;

sorted_user_post_data_list = foreach sorted_user_post_data generate displayname, COUNT(posts_data.owneruserid), reputation ;

max_reputation = LIMIT sorted_total_user_post 1;

dump max_reputation;
 
store max_reputation into 'stackoverflow_result/s1' using pigstorage('\t','-schema');



##############################################################33

B) 
group_post_by_user = group user_post_data ALL ;

avg_age = foreach users_data generate AVG(age);

store avg_age into 'stackoverflow_result/s2' using pigstorage('-schema');






