
CREATE SCHEMA SE2222;
USE SE2222;

-- 1. Definitions:
-- (15 points)
-- All table definitions of your project including any constraints
-- Before each table creation give a short explanation of the table

-- It stores the nationalities of the players.
create table Nationality (
	NationalityID int not null auto_increment,
	NationalityName varchar(50) not null,
	primary key (NationalityID)
);

-- It stores the Countries of the City.
create table Country (
CountryID int not null auto_increment,
CountryName varchar(50) not null,
PRIMARY KEY(CountryID)
);

-- It stores the names of the cities and which country they belong to.
create table City (
	CityID int not null auto_increment,
	CityName varchar(50) not null,
	CountryID int,
	primary key (CityID),
	foreign key (CountryID) references Country(CountryID)
);

-- It stores the Positions of the Players.
create table Positions (
	PositionID int not null auto_increment,
	PositionName varchar(50) not null,
	primary key (PositionID)
);

-- It stores the Leagues.
create table League (
	LeagueID int not null auto_increment,
	LeagueName varchar(50) not null,
	primary key (LeagueID)
);

-- It stores the name of the team, the name of the stadium, the name of the team coach, the city where it is located, and the league.
create table Team (
	TeamID int not null auto_increment,
	TeamName varchar(50) not null,
	StadiumName varchar(50) not null,
	CoachName varchar(50) not null,
	CityID int,
    LeagueID int,
	primary key (TeamID),
	foreign key (CityID) references City(CityID),
    foreign key (LeagueID) references League(LeagueID)
);

-- It stores the players' names, birth dates, nationalities, teams, positions and height.
create table Player (
	PlayerID int not null auto_increment,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	DateOfBirth date,
	NationalityID int,
	TeamID int,
	PositionID int,
    Height varchar(5),
	primary key (PlayerID),
	foreign key (NationalityID) references nationality(NationalityID),
	foreign key (TeamID) references team(TeamID),
	foreign key (PositionID) references positions(PositionID)
);

-- It stores the Season.
create table Season (
	SeasonID int not null auto_increment,
	Seasonname varchar(50) not null,
	primary key (SeasonID)
);

-- It stores among which teams the match was played, in which season and in which league it was played.
create table Game (
	GameID int not null auto_increment,
	HomeTeamID int not null references team(TeamID),
	AwayTeamID int not null references team(TeamID),
	SeasonID int not null references season(SeasonID),
	LeagueID int not null references league(LeagueID),
	GameDate date,
	primary key (GameID)
);

-- It stores the Scores of the game.
create table Scores (
	ScoresID int not null auto_increment,
	GameID int not null references game(GameID),
	PlayerID int not null references player(PlayerID),
	TeamID int not null references team(TeamID),
	minutes int,
	primary key (ScoresID)
);

-- It stores track of which player played in which team in which game and scored in the minute of the game..
create table TeamLeagueSeason (
	TeamLeagueSeasonID int not null auto_increment,
	TeamID int not null references team(TeamID),
	LeagueID int not null references league(LeagueID),
	SeasonID int not null references season(SeasonID),
	primary key (TeamLeagueSeasonID)
);

-- 2. Insertions(Data manipulation):
-- (15 points)
-- For each table, add enough number of rows to make your queries in step three to produce meaningful result sets.

insert into Nationality(NationalityName) VALUES
('GB'), ('TR'),('IT'),('DE'),('FR'),('SP'),('PL'),('BR'),('A'),('RCH'),('P'),('ET'),('ROU'),('HR'),
('ABD'),('CDN');

insert into Country(CountryName) VALUES
('Great Britain'), ('Turkey'),('Italy'),('Germany'),('France'),('Spain');

insert into City (CityName, CountryID) values ('München', 4), ('Dortmund',4), ('Paris', 5),('Monaco',5), ('Manchester', 1), ('Istanbul', 2), ('Barcelona',6), ('Madrid', 6), 
('Torino',3), ('Milan', 3);

insert into League (LeagueName) values ('Bundesliga'), ('Ligue 1'), ('Premier League'), ('Super League'), ('Serie A'), ('La Liga');

insert into Team (TeamName, StadiumName, CoachName, CityID, LeagueID) values 
('FC Bayern München',  'Allianz Arena', 'Josep Guardiola', 1, 1), 
('Borussia Dortmund',  'Signal Iduna Park', 'Edin Terzić', 2, 1), 
('FC Paris Saint-Germain',  'Parc des Princes', 'Mauricio Pochettino', 3, 2), 
('AS Monaco FC',  'II. Louis Stadium', 'Niko Kovač', 4, 2), 
('Manchester United FC',  'Old Trafford', 'Ole Gunnar Solskjær', 5, 3), 
('Manchester City FC',  'Manchester City Stadium', 'Pep Guardiola', 5, 3), 
('Fenerbahçe',  'Fenerbahçe Şükrü Saracoğlu Stadyumu', 'Emre Belözoğlu', 6, 4), 
('Galatasaray',  'Türk Telekom Arena', 'Fatih Terim', 6, 4), 
('FC Barcelona',  'Camp Nou', 'Ronald Koeman', 7, 6), 
('Real Madrid CF',  'Santiago Bernabéu Stadium', 'Zinédine Zidane', 8, 6), 
('Juventus FC',  'Juventus Stadium', 'Andrea Pirlo', 9 , 5), 
('AC Milan',  'Giuseppe Meazza Stadium', 'Stefano Pioli', 10, 5);

insert into Positions (PositionName) values ('Goalkeeper'), ('Defence'), ('Midfield'), ('Forward'); 

insert into player (FirstName, LastName, DateOfBirth, NationalityID, PositionID, TeamID, Height) values
('Robert', 'Lewandowski', '1988-8-21', 7, 4, 1, '1.85'),
('David', 'Alaba', '1992-6-24', 9, 2, 1, '1.8'),
('Leroy', 'Sane', '1996-1-11', 4, 4, 1, '1.83'),
('Leon', 'Goretzka', '1995-2-6', 4, 3, 1, '1.89'),
('Marco', 'Reus', '1989-5-31', 4, 4, 2, '1.85'),
('Erling', 'Håland', '2000-7-21', 1, 4, 2, '1.94'),
('Kylian','Mbappé','1998-12-20', 5, 4, 3, '1.78'),
('Kevin','Volland','1992-7-30', 4, 4, 4, '1.78'),
('Fàbregas','Soler','1987-5-4', 6, 3, 4, '1.80'),
('Sofiane','Diop','2000-6-9', 5, 3, 4, '1.75'),
('Guillermo','Maripán','1994-5-6', 10, 2, 4, '1.93'),
('Bruno','Fernandes','1994-9-8', 11, 3, 5, '1.79'),
('Luke','Shaw','1995-7-12', 1, 2, 5, '1.85'),
('Mostafa','Mohamed','1997-11-28', 12, 4, 8, '1.85'),
('Anssumane ','Fati','2002-10-31', 6, 4, 9, '1.78'),
('Óscar','Mingueza','1999-5-13', 6, 2, 9, '1.84'),
('Federico','Valverde','1998-7-22', 13, 3, 10, '1.85'),
('Sergio','Ramos','1986-3-30', 6, 2, 10, '1.84'),
('Luka','Modrić','1985-9-9', 14, 3, 10, '1.72'),
('Karim','Benzema','1987-12-19', 5, 4, 10, '1.85'),
('Toni','Kroos','1990-1-4', 4, 3, 10, '1.83'),
('Davide','Calabria','1996-12-6', 3, 2, 12, '1.77'),
('Federico','Chiesa','1997-10-25', 3, 4, 11, '1.75'),
('Weston','McKennie','1998-8-28', 15, 3, 11, '1.85'),
('Brahim','Díaz','1999-8-3', 6, 4, 12, '1.71'),
('Ante','Rebić','1993-9-21', 14, 4, 12, '1.85'),
('Fikayo','Tomori','1997-12-19', 16, 2, 12, '1.85');

insert into Season (SeasonName) values ('2020/21');

insert into TeamLeagueSeason (TeamID, SeasonID, LeagueID) values 
(1,1,1),
(2,1,1),
(3,1,2),
(4,1,2),
(5,1,3),
(6,1,3),
(7,1,4),
(8,1,4),
(9,1,6),
(10,1,6),
(11,1,5),
(12,1,5);

insert into Game (HomeTeamID, AwayTeamID, SeasonID, LeagueID, GameDate) values 
(2, 1, 1, 1,'2020-11-7'),
(1, 2, 1, 1,'2020-3-6'),
(4, 3, 1, 2,'2020-11-20'),
(3, 4, 1, 2,'2020-2-21'),
(5, 6, 1, 3,'2020-12-12'),
(6, 5, 1, 3,'2020-3-7'),
(8, 7, 1, 4,'2020-9-27'),
(7, 8, 1, 4,'2020-2-6'),
(9, 10, 1, 6,'2020-10-24'),
(10, 9, 1, 6,'2020-4-10'),
(12, 11, 1, 5,'2020-1-6'),
(11, 12, 1, 5,'2020-5-9');

insert into Scores (GameID, PlayerID, TeamID, minutes) values
(1,5,2,45),
(1,6,2,83),
(1,2,1,49),
(1,1,1,48),
(1,3,1,80),
(2,6,2,2),
(2,6,2,9),
(2,1,1,26),
(2,1,1,44),
(2,4,1,88),
(2,1,1,90),
(3,8,4,52),
(3,8,4,65),
(3,9,4,84),
(3,7,3,25),
(3,7,3,37),
(4,10,4,6),
(4,11,4,51),
(6,12,5,2),
(6,13,5,50),
(8,14,8,54),
(9,15,9,8),
(9,17,10,5),
(9,18,10,63),
(9,19,10,90),
(10,20,10,13),
(10,21,10,28),
(10,16,9,60),
(11,22,12,41),
(11,23,11,18),
(11,23,11,62),
(11,24,11,76),
(12,25,12,46),
(12,26,12,78),
(12,27,12,82);
 
-- 3. Queries:
-- (15 points)
-- Write 5 queries with explanations 
-- Write 5 queries. Your queries should do a task that is meaningful in your selected context (project topic). 

-- In this query, I printed the names and positions of the players whose ID is less than the data coming from the subquery by adding a alias
select firstName as Name, lastName as Surname, positionName as Role
from player , positions
where playerID < (SELECT playerID 
				  from player 
				  where LastName = 'Volland') 
                  and player.positionID = positions.positionID;

-- In this query, I printed the IDs of the matches and the away teams in that match by joining and sorted them according to the match ID.
select game.GameID, team.TeamName
from game
right join team on game.AwayTeamID = team.TeamID
order by gameID;

-- In this query, I printed the square root of the sum of the players' heights by adding alias.
select sqrt(sum(height)) as SquareRootHeights
from player;

-- I deleted a player from the player table using a sub query.
delete from player  
where playerID = ANY(select PlayerID 
					from player 
					where playerId=6);

-- I updated the date of the game by using the game ID.
update game set gameDate = '2020-11-8' 
where gameID = (select min(scoresID) 
				from scores 
				where scores.gameID = game.GameID);





