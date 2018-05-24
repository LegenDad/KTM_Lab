show databases;
use test;
show tables;

select * from udata limit 5;
select * from uitem limit 5;
select * from uuser limit 5;

select count(*) from udata;
select count(*) from uitem;
select count(*) from uuser;

select * from udata limit 10;
select distinct userId from udata;
select count(distinct userId) from udata;
select count(distinct itemId) from udata;
select count(distinct rating) from udata;
select count(distinct time) from udata;

select count(distinct movie_id) from uitem;
select count(distinct movie_title) from uitem;
select count(distinct release_date) from uitem;

select count(distinct userId) from uuser;
select count(distinct age) from uuser;
select count(distinct gender) from uuser;
select count(distinct occupation) from uuser;
select count(distinct zipCode) from uuser;

select count(distinct occupation), count(distinct zipCode) from uuser;

select count(isnull(video_release_date)) from uitem;
select count(isnull(action)) from uitem;
select count(*) from uitem where action is null;
select count(action is null) from uitem;

select count(case when video_release_date is null then null else video_release_date end) from uitem;
select count(case when action is null then null else action end) from uitem;
select count(case when acton is null then null else action end) from uitem;

select count(*) from uitem where substr(release_date, 8, 4) = '1995' AND action = 1;
select count(*) from uitem where substr(release_date, 8, 4) = '1995' AND animation = 1;
select count(*) from uitem where substr(release_date, 8, 4) = '1996' AND comedy = 1;

select userId, count(distinct rating) df_fre, count(rating) f from udata group by userId;
select itemId, count(distinct rating) df_fre, count(rating) f from udata group by itemId;

select userId, count(distinct rating) df_fre, count(rating) f from udata 
group by userId order by f desc;


select * from udata limit 10;
select userId, count(distinct rating) df_fre, count(rating) f from udata 
group by userId having f > 600;

select userId, count(distinct rating) df_fre, count(rating) f from udata 
group by userId having f > 600
order by f desc;

select itemId, count(rating) f from udata group by itemId ;
select itemId, count(rating) f from udata group by itemId having f > 600;
select itemId, count(rating) f from udata group by itemId having f > 500 order by f;