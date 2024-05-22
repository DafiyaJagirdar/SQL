# select followed by column details
# followed from and then joins
# then where then group by then
# order by and finally limit

#query movie table
#in table Column represents variable
#variable is an unique feature
select * from movie; # * means select all
#select cloumn title only
select title from movie;
# select multiple columns
select title,revenue,budget,runtime 
from movie;
# Where clause is used for filtering records
# Records meeting a specified condition only
# exctracted
#logical operators are used in where clause are
# > ,<,>=,<=,!=,Between, like , in

# select movies with runtime greater than 90 minutes
# output must have 2 columns - title, runtime
select title,runtime
from movie
where runtime>=90 order by runtime desc;

#select top 30 movies whose runtime is between 90 to 120 minute
select title,runtime
from movie 
where runtime between 90 and 120
order by runtime desc limit 30; #top 30 is the limit

#statistical functions used on numeric variables
#min(), max(), avg()-mean,std()-standard deviation
#count(),sum()
select count(runtime),min(runtime),max(runtime),
avg(runtime),std(runtime) 
from movie;

select count(budget),min(budget),max(budget),
avg(budget),std(budget)
from movie;

#how many title are runtime greater than 106 minutes

select count(title) 
from movie
where runtime > 106 ;

#how many movies with runtime 0
select count(title) as Frequency  
from movie
where runtime = 0;

#like pattern list of the columns startin with p
#The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
#2 wild cards are used with like operator
#the percent sign (%) represents zero, one or multiple characters
#the underscore sign(_) represents one, single character
select title 
from movie
where title Like 'p%';

select count(title)
from movie
where title Like 'p%';

select title 
from movie
where title Like '%Fast%';

select title 
from movie
where title Like '%Fast';

select count(title)
from movie
where title Like '%God%';

select title,runtime,budget 
from movie
where runtime>150 and budget>200000000;	

select count(title)
from movie
where runtime>150 and budget>200000000;

#Group By -summarise numerical data based on categorical(non-numeric) condition.
#Group By must be used with aggregate function like count, sum,min, max ,mean avg, std etc.

#Group By -basic syntax and usage
#SELECT column_name(s)
#FROM table_name
#WHERE condition
#GROUP BY column_name(s)   #this should be categorical or non-numerical column
#ORDER BY column_name(s);

#identify distinct categories in movie-status
select distinct movie_status from movie;

#frequency counts of Movie_status
select movie_status ,count(movie_status) as Frequency
from movie
group by movie_status;

#what is the average budget of differnet movie_status?
select movie_staus ,avg(budget) as avgBudget
from movie
Group by movie_status;

#what is the standard deviation of vote_count for differnet movie_status
select movie_status, std(vote_count) as standard_dev
from movie
group by movie_status;

#joins used for multi table querying. Differnt types of joins are used like inner, left,right, and cross/full
#there are differnt methods to use joins in mysql
# 1) natural join (default inner or left join) - no need to specify common/variable .it automatically detects
# 2) join using(common colname) - in this method common column must be specified.

#how many differnt genre(genre_name) movies are there
#Join 3 tables - movie, movie , genre
select genre_name,count(title) as frequency 
from movie
natural join movie_genres natural join genre
group by genre_name order by Frequency desc;

#same query can also be written using join
select genre_name,count(title) as Frequency 
from movie
join movie_genres using (movie_id)
join genre using (genre_id)
group by genre_name order by Frequency desc;

#frequency count of movies produced by different production company
select company_name ,count(title) as Frequency
from movie
join movie_company using (movie_id)
join production_company using (company_id)
group by company_name order by Frequency desc;

select company_name ,count(title) as Frequency
from movie
natural join movie_company 
natural join production_company 
group by company_name order by Frequency desc;

#frequency count of movies produced in differnet countries
select country_name ,count(title) as Frequency
from movie
natural join country
natural join production_country
group by country_name order by Frequency desc;

select country_name ,count(title) as Frequency
from movie
join production_country using (movie_id)
join country using (country_id)
group by country_name order by Frequency desc;

#top 20 most popular action moves
select title,popularity,genre_name
from movie 
natural join movie_genres
natural join genre
where genre_name='Action'
order by popularity desc limit 20;

#who are the directors of top 20 most popular movies
select distinct title,popularity,department_name
from movie
natural join person
natural join department
natural join movie_crew
where department_name='Directing'
order by popularity desc limit 20;

#most top 20 popluar movie directed by female directors with name
select distinct title,person_name,popularity,department_name
from movie
natural join gender
natural join movie_cast
natural join person
natural join department
where gender='Female' and department_name='Directing'
order by popularity desc limit 20;

#movies directed by steven spielberg
select distinct title,popularity,department_name
from movie
natural join movie_cast
natural join department
natural join person
where person_name='steven spielberg' and department_name='Directing'
order by popularity desc;

#what is the average budget of differnt genre_name movies?
select distinct genre_name,avg(budget) as Budget
from movie
natural join movie_genres
natural join genre
group by genre_name order by Budget Desc;

#what is the average Vote_count for different genre movies
select genre_name, avg(vote_count) as Votecount
from movie
natural join movie_genres
natural join genre
group by genre_name order by Votecount desc;


#what is the average revenue for movies produced by different production company
select company_name, avg(revenue) as Revenue
from movie
natural join production_company
natural join movie_company
group by company_name order by Revenue desc;

#Date Functions --> Working with Dates
#default date format is "yyyy-mm-dd", or "yyyy/mm/dd" or 
#datetime format - "yyyy-mm-dd HH:MM:SS"
#date functions are year(),month(),day(),etc.alter

#how many movies produced in each year
select year(release_date) as year, count(title) as frequency
from movie
group by year(release_date) order by year asc; 

#how many movies release year wise and month wise
select year(release_date) as year,month(release_date) as month, count(title) as frequency
from movie
group by year(release_date), month(release_date) order by year asc; 

#how many movies relese in the year 2014
select year(release_date) as year,count(title) as frequency
from movie
where year(release_date)=2014
group by year(release_date);

#how many drama movie release each year
select * from genre;

select year(release_date) as year,count(title) as frequency, genre_name
from movie
natural join genre
natural join movie_genres
where genre_name='Drama'
group by year order by year asc;

select * from genre;

select year(release_date) as year,count(title) as frequency, genre_name
from movie
natural join genre
natural join movie_genres
where genre_name='Action'
group by year order by year asc;

#how many movies each director directed
select count(title) as Frequency, person_name
from movie 
natural join person
natural join movie_cast
natural join movie_crew
natural join department
where department_name='Directing'
group by person_name order by frequency desc;

#list of all actors acted in movies minions
select title, person_name, department_name
from movie
natural join person
natural join department
natural join movie_cast
where title='Minions' and department_name='Actors';

#who are the directors of top 20 revenue movies
select Distinct person_name,revenue,department_name
from movie
natural join movie_crew
natural join person
natural join department
where department_name='Directing'
order by revenue desc limit 20;


