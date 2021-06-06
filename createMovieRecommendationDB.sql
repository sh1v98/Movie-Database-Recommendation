CREATE TABLE users (
       userid INTEGER NOT NULL,
       name TEXT NOT NULL,
       PRIMARY KEY (userid));

CREATE TABLE movies (
       movieid INTEGER NOT NULL,
       title TEXT NOT NULL,
       PRIMARY KEY (movieid));

CREATE TABLE genres (
       genreid INTEGER NOT NULL,
       name TEXT NOT NULL,
       PRIMARY KEY (genreid));


CREATE TABLE taginfo (
       tagid INTEGER NOT NULL,
       content TEXT NOT NULL,
       PRIMARY KEY (tagid));

CREATE TABLE ratings (
       userid INTEGER,
       movieid INTEGER,
       rating NUMERIC NOT NULL CHECK(rating>=0 and rating<=5),
       timestamp BIGINT NOT NULL,
       FOREIGN KEY (userid) REFERENCES users,
       FOREIGN KEY (movieid) REFERENCES movies,
       PRIMARY KEY(userid,movieid));


CREATE TABLE tags (
       userid INTEGER,
       movieid INTEGER,
       tagid INTEGER,
       timestamp BIGINT,
       FOREIGN KEY (userid) REFERENCES users,
       FOREIGN KEY (movieid) REFERENCES movies,
       FOREIGN KEY (tagid) REFERENCES taginfo,
       PRIMARY KEY(userid,movieid,tagid));

CREATE TABLE hasagenre(
       movieid INTEGER,
       genreid INTEGER,
       FOREIGN KEY (movieid) REFERENCES movies,
       FOREIGN KEY (genreid) REFERENCES genres,
       PRIMARY KEY(movieid,genreid)
);
