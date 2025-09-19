# SQL

## Write a SQL script that creates a new user, and database. Make the user the owner of the db.

* create database IPL;

* create user "sumit" identified by "123";
  GRANT ALL PRIVILEGES ON IPL.* TO 'sumit'@'localhost';
  FLUSH PRIVILEGES;

## Write another SQL script that cleans up the user, and database created in the previous step.

DROP DATABASE IF EXISTS IPL;
DROP USER 'sumit'@'localhost';
FLUSH PRIVILEGES;

## Write a SQL script that loads CSV data into a table.

LOAD DATA LOCAL INFILE 'A:/jarFile/IPL/meta-data/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@match_id, @season, @city, @match_date, @team1, @team2, @toss_winner, @toss_decision,
 @result, @dl_applied, @winner, @win_by_runs, @win_by_wickets, @player_of_match,
 @venue, @umpire1, @umpire2, @umpire3)
SET
match_id        = NULLIF(@match_id,''),
season          = NULLIF(@season,''),
city            = NULLIF(@city,''),
match_date      = NULLIF(@match_date,''),
team1           = NULLIF(@team1,''),
team2           = NULLIF(@team2,''),
toss_winner     = NULLIF(@toss_winner,''),
toss_decision   = NULLIF(@toss_decision,''),
result          = NULLIF(@result,''),
dl_applied      = NULLIF(@dl_applied,''),
winner          = NULLIF(@winner,''),
win_by_runs     = NULLIF(@win_by_runs,''),
win_by_wickets  = NULLIF(@win_by_wickets,''),
player_of_match = NULLIF(@player_of_match,''),
venue           = NULLIF(@venue,''),
umpire1         = NULLIF(@umpire1,''),
umpire2         = NULLIF(@umpire2,''),
umpire3         = NULLIF(@umpire3,'');


LOAD DATA LOCAL INFILE 'C:/path/to/deliveries.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@match_id, @inning, @batting_team, @bowling_team, @over, @ball,
 @batsman, @non_striker, @bowler, @is_super_over, @wide_runs, @bye_runs,
 @legbye_runs, @noball_runs, @penalty_runs, @batsman_runs, @extra_runs,
 @total_runs, @player_dismissed, @dismissal_kind, @fielder)
SET
match_id        = NULLIF(@match_id,''),
inning          = NULLIF(@inning,''),
batting_team    = NULLIF(@batting_team,''),
bowling_team    = NULLIF(@bowling_team,''),
`over`          = NULLIF(@over,''),
ball            = NULLIF(@ball,''),
batsman         = NULLIF(@batsman,''),
non_striker     = NULLIF(@non_striker,''),
bowler          = NULLIF(@bowler,''),
is_super_over   = NULLIF(@is_super_over,''),
wide_runs       = NULLIF(@wide_runs,''),
bye_runs        = NULLIF(@bye_runs,''),
legbye_runs     = NULLIF(@legbye_runs,''),
noball_runs     = NULLIF(@noball_runs,''),
penalty_runs    = NULLIF(@penalty_runs,''),
batsman_runs    = NULLIF(@batsman_runs,''),
extra_runs      = NULLIF(@extra_runs,''),
total_runs      = NULLIF(@total_runs,''),
player_dismissed= NULLIF(@player_dismissed,''),
dismissal_kind  = NULLIF(@dismissal_kind,''),
fielder         = NULLIF(@fielder,'');

## Number of matches played per year of all the years in IPL.

select season, count(`*`) from matches group by season ORDER BY season;

## Number of matches won of all teams over all the years of IPL.

select season, winner, count(`*`) from matches group by winner, season order by season, winner;

## For the year 2016 get the extra runs conceded per team.

select d.bowling_team AS Team, SUM(d.extra_runs) AS Extra_Runs_Conceded from deliveries d
JOIN matches m ON d.match_id = m.match_id where m.season = 2016
group by d.bowling_team order by Extra_Runs_Conceded desc;

## For the year 2015 get the top economical bowlers.

select d.bowler, round(sum(d.total_runs) / (sum(case when d.wide_runs = 0 and d.noball_runs = 0 then 1 else 0 end) / 6), 2) AS economy from deliveries d
JOIN matches m ON d.match_id = m.match_id where m.season = 2015 group by d.bowler having sum(case when d.wide_runs = 0 AND d.noball_runs = 0 then 1 else 0 end) > 6
order by economy limit 1;

## Find match details using matchId.

Select * from matches where match_id = 636;

## Find last 5 match details.

select * from matches order by match_id desc limit 5;

## Find partnership between "S dhawan" and other.

select batsman, non_striker, sum(batsman_runs) from deliveries where batsman = "S Dhawan" 
group by batsman, non_striker;