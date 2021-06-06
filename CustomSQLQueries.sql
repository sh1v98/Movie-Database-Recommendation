-- query1
CREATE TABLE query1 AS
SELECT  ge.name,count(ge.genreid) AS moviecount
FROM genres ge,hasagenre h
WHERE ge.genreid=h.genreid
GROUP BY ge.genreid;

-- query2
CREATE table query2 AS
SELECT ge.name ,AVG(rating) as rating
FROM genres ge,hasagenre h,ratings r
WHERE ge.genreid=h.genreid AND h.movieid=r.movieid
GROUP BY ge.genreid;

-- query3
CREATE TABLE query3 AS
SELECT mov.title,COUNT(rat.rating) as countofratings
FROM movies mov
INNER JOIN ratings rat
ON mov.movieid = rat.movieid
GROUP BY mov.title
HAVING COUNT(rat.rating) >= 10;

-- query4
CREATE TABLE query4 AS 
SELECT mov.movieid as movieid,mov.title as title
FROM movies mov,genres gen,hasagenre h
WHERE mov.movieid=h.movieid 
AND h.genreid=gen.genreid
AND gen.name='Comedy';

-- query5
CREATE TABLE query5 AS 
SELECT mov.title as title,Avg(rating) as average
FROM movies mov,ratings rat
WHERE mov.movieid=rat.movieid 
GROUP BY mov.movieid;

-- query6
CREATE TABLE query6 AS 
SELECT Avg(rating) as average
FROM movies mov,genres gen,hasagenre h,ratings rat
WHERE mov.movieid=h.movieid 
and mov.movieid=rat.movieid
and h.genreid=gen.genreid
and gen.name='Comedy';

-- query7
CREATE View view7 AS 
SELECT distinct mov.title as title, mov.movieid as movieid
FROM movies mov,genres genc,genres genr,hasagenre h1,hasagenre h2
where mov.movieid=h1.movieid 
and h1.genreid=genc.genreid
and mov.movieid=h2.movieid
and h2.genreid=genr.genreid
and genc.name='Comedy'
and genr.name='Romance'
and genc.name!=genr.name;

CREATE TABLE query7 AS
SELECT Avg(rating) as rating
FROM view7 vw,ratings rat
where vw.movieid=rat.movieid;

-- query8
create view view8 as 
select h.movieid as movieid
from hasagenre h,genres gen
where h.genreid=gen.genreid
and gen.name='Romance';

create table query8 as
select Avg(rating) as avg_rat
from view8 v8,ratings rat
where v8.movieid=rat.movieid
and v8.movieid not in(select h.movieid as movieid
			from hasagenre h,genres gen
			where h.genreid=gen.genreid
			and gen.name='Comedy');

-- query9
CREATE TABLE query9 AS 
SELECT mov.movieid as movieid,rat.rating as rating
FROM movies mov,ratings rat
where mov.movieid=rat.movieid
and rat.userid=:v1;

-- recommendation
create view vl as
select mov.movieid as movieid,mov.title as title,rat.userid as userid,rat.rating as rating
from movies mov,ratings rat
where mov.movieid=rat.movieid
and rat.userid=:v1;

create view vi as
select mov.movieid as movieid,mov.title as title,rat.userid as userid,rat.rating as rating
from movies mov,ratings rat
where mov.movieid=rat.movieid
and rat.userid!=:v1;

create view avgrat AS 
select mov.title as title,mov.movieid as movieid,AVG(rating) as average
from movies mov,ratings rat
where mov.movieid=rat.movieid 
Group by mov.movieid;


Create view similarity_calc as
select mov1.movieid as m1,mov2.movieid as m2,1-(abs(avgi.average-avgl.average)/5) as similar
from movies mov1,movies mov2,avgrat avgi,avgrat avgl
where mov1.movieid=avgi.movieid
and mov2.movieid=avgl.movieid;


create view similar_rating as
select distinct vi.movieid as m1,vl.movieid as m2,sm.similar as sim,vl.rating as ratingof_ua_l,sm.similar*vl.rating as product
from similarity_calc sm,vi ,vl
where sm.m1=vi.movieid
and sm.m2=vl.movieid;

create view calci as
select mov.title as title,sum(product)/sum(sim) as result
from sim_rating sm,movies mov
where sm.m1=mov.movieid
group by mov.movieid;

create table recommendation as	
select p.title as title
from calci p
where result>3.9;