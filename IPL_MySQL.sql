-- Write a SQL script that creates a new user, and database. Make the user the owner of the db.

create database IPL;
create user "sumit" identified by "123";
GRANT ALL PRIVILEGES ON IPL.* TO 'sumit'@'localhost';
  
-- Write another SQL script that cleans up the user, and database created in the previous step.

DROP DATABASE IF EXISTS IPL;
DROP USER 'sumit'@'localhost';
FLUSH PRIVILEGES;

use IPL;

select * from matches;
select * from deliveries;

-- Number of matches played per year of all the years in IPL.
select season, count(*) from matches group by season ORDER BY season;

-- Number of matches won of all teams over all the years of IPL.
select season, winner, count(*) from matches group by winner, season order by season, winner;

-- For the year 2016 get the extra runs conceded per team.
select d.bowling_team AS Team, SUM(d.extra_runs) AS Extra_Runs_Conceded from deliveries d
JOIN matches m ON d.match_id = m.match_id where m.season = 2016
group by d.bowling_team order by Extra_Runs_Conceded desc;

-- Find best economy bowler.
SELECT d.bowler, ROUND(SUM(d.total_runs) / (COUNT(*) / 6.0), 2) AS economy FROM deliveries d
JOIN matches m ON d.match_id = m.match_id WHERE m.season = 2015 AND d.wide_runs = 0 AND d.noball_runs = 0
GROUP BY d.bowler HAVING COUNT(*) > 6 ORDER BY economy ASC LIMIT 1;


-- Find match details using matchId.
Select * from matches where match_id = 636;

-- Find partnership between "S dhawan" and other.
select batsman, non_striker, sum(batsman_runs) from deliveries where batsman = "S Dhawan" 
group by batsman, non_striker;
