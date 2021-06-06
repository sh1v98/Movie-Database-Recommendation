# Movie-Database-Recommendation
Create a movie recommendation database from scratch and build applications on top of this database

The movie database includes multiple tables. In particular, there are seven tables which are: users, movies, taginfo, genres, ratings, tags, hasagenre. Creating these tables and load the corresponding data into these tables.
img 1
1. The description of the tables is as follows.
 
users: userid (int, primary key), name (text)

movies: movieid (integer, primary key), title (text)

taginfo: tagid (int, primary key), content (text)

genres: genreid (integer, primary key), name (text)

ratings: userid (int, foreign key), movieid (int, foreign key), rating (numeric), timestamp (bigint, seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970)

tags: userid (int, foreign key), movieid (int, foreign key), tagid (int, foreign key), timestamp (bigint, seconds since midnight Coordinated Universal Time (UTC) of January 1, 1970).

hasagenre: movieid (int, foreign key), genreid (int, foreign key)

After this as we now have the tables and data loaded. Writing custom queries to return the following: 
1. Total number of movies for each genre. Query result is saved in a table called “query1” which has two attributes: name, moviecount.
2. Average rating per genre. Query result is saved in a table called “query2” which has two attributes: name, rating.
3. Movies have at least 10 ratings. Query result is saved in a table called “query3” which has two attributes: title, CountOfRatings.
4. All “Comedy” movies, including movieid and title. Query result is saved in a table called “query4” which has two attributes, movieid and title.
5. Average rating per movie. Query result is saved in a table called “query5” which has two attributes, title and average.
6. Average rating for all “Comedy” movies. Query result is saved in a table called “query6” which has one attribute, average.
7. Average rating for all movies and each of these movies is both “Comedy” and “Romance”. Query result is saved in a table called “query7” which has one attribute, average.
8. Average rating for all movies and each of these movies is “Romance” but not “Comedy”. Query result is saved in a table called “query8” which has one attribute, average.
9. All movies that are rated by a User such that the userId is equal to v1. The v1 will be an integer parameter passed to the SQL query. Your query result should be saved in a table called “query9” which has two attributes, movieid and rating.
10. Now SQL query to create a recommendation model using item-based collaborative filtering. Given a userID v1(the same parameter used in q9), will recommend the movies according to the movies he has rated before. In particular, it will predict the rating P of a movie i that the user Ua didn’t rate. In the following recommendation model, P(Ua, i) is the predicted rating of movie i for User Ua. L contains all movies that have been rated by Ua. Sim(i,l) is the similarity between i and l. r is the rating that Ua gave to l. This SQL query should return predicted ratings from all movies that the given user hasn’t rated yet and named as 'query10'. 


