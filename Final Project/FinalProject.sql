-- check if project exists
USE master;

GO

DROP DATABASE IF EXISTS [INFO6150-22Spring-Team6-FinalProject];
CREATE DATABASE [INFO6150-22Spring-Team6-FinalProject]; 

GO 

USE [INFO6150-22Spring-Team6-FinalProject];


--Create Tables

--Coach Table
create table Coach(
CoachID int identity(1,1) primary key,
CoachFirstName varchar(255) not null,
CoachLastName varchar(255) not null);
--insert Coach Values
insert Coach(CoachFirstName,CoachLastName) 
values('Jimmy','Kerr'),
('Nate',' McMillan'),
('Ime','Udoka'),
('Steve','Nash'),
('James','Borrego'),
('Donald','Trump'),
('Jason','Kidd'),
('Michael','Malone'),
('Tyronn','Lue'),
('Gregg','Popovich');


--Team Table
create table Team(
TeamID int identity(1,1) primary key,
CoachID int foreign key references Coach(CoachID),
TeamName varchar(255) not null);
--Insert Team Values  可以加procedure
insert Team(CoachID,TeamName) 
values(1,'Worriors'),
(2,'Hawks'),
(3,'Celtics'),
(4,'Nets'),
(5,'Hornets'),
(6,'Lakers'),
(7,'Mavericks'),
(8,'Nuggets'),
(9,'Clippers'),
(10,'Spurs');

--Player Table
create table Player(
PlayerID int identity(1,1) primary key,
TeamID int foreign key references Team(TeamID),
CoachID int foreign key references Coach(CoachID),
PlayerFirstName varchar(255) not null,
PlayerLastName varchar(255) not null);
--Insert Player Values
insert Player(TeamID,CoachID,PlayerFirstName,PlayerLastName) 
values(1,1,'Stephen','Curry'),
(1,1,'Andrew','Wiggins'),
(1,1,'Draymound','Green'),
(1,1,'Andrie','Iguodala'),
(2,2,'Trae','Young'),
(2,2,'Clint','Capela'),
(3,3,'Jayson','Tatum'),
(3,3,'Jaylen','Brown'),
(4,4,'Kevin','Durant'),
(4,4,'Patty','Mills'),
(5,5,'LaMelo','Ball'),
(5,5,'Mils','Bridges'),
(6,6,'Russell','Westbrook'),
(6,6,'Anthony','Davis'),
(7,7,'Luka','Doncic'),
(7,7,'Jalen','Brunson'),
(8,8,'Nikola','Jokic'),
(8,8,'Monte','Morris'),
(9,9,'Reggie','Jackson'),
(9,9,'Ivica','Zubac'),
(10,10,'Dejounte','Murray'),
(10,10,'Jakob','Poeltl');

--TranningHall Table
create table TrainingHall(
TrainingHallID int identity(1,1) primary key,
TeamID int foreign key references Team(TeamID),
Name varchar(255) not null);

GO

--Insert TranningHall Values
CREATE OR ALTER PROCEDURE addTrainningHallProcedure
	@TeamID INT,
    @Name VARCHAR(255)
AS
BEGIN
	INSERT INTO dbo.TrainingHall 
	VALUES (@TeamID,@Name);
END
GO
EXECUTE addTrainningHallProcedure 1,'Chase Center';
EXECUTE addTrainningHallProcedure 2,'State Farm Arena';
EXECUTE addTrainningHallProcedure 3,'TD Garden';
EXECUTE addTrainningHallProcedure 4,'Barclays Center';
EXECUTE addTrainningHallProcedure 5,'Spectrum Center';
EXECUTE addTrainningHallProcedure 6,'Crypto.com Arena';
EXECUTE addTrainningHallProcedure 7,'American Airlines Center';
EXECUTE addTrainningHallProcedure 8,'Ball Arena';
EXECUTE addTrainningHallProcedure 9,'Crypto.com Arena';
EXECUTE addTrainningHallProcedure 10,'AT&T Center';

GO

create table City(
CityID int identity(1,1) primary key,
State varchar(255) not null,
CityName varchar(255) not null);
-- Insert City Data
go
create or alter procedure addCityProcedure
	@State varchar(255),
	@CityName varchar(255)
as
begin
	insert into dbo.City(State,CityName)
	values(@State,@CityName);
end
go

execute addCityProcedure 'MA','Boston';
execute addCityProcedure 'CA','Los Angeles';
execute addCityProcedure 'CA','San Francisco';
execute addCityProcedure 'TX','Dallas';
execute addCityProcedure 'NY','Brooklyn';
execute addCityProcedure 'NY','New York City';
execute addCityProcedure 'FL','Miami';
execute addCityProcedure 'WI','Milwaukee';
execute addCityProcedure 'IL','Chicago';
execute addCityProcedure 'OR','Portland';

go
--Stadium Table
create table Stadiums(
ID int identity(1,1) primary key,
CityID int foreign key references City(CityID),
TeamID int foreign key references Team(TeamID),
Seats int not null);
-- Insert Stadiums Data
go
create or alter procedure addStadiums
	@CityID int,
	@TeamID int,
	@Seats int
as
begin
	insert into dbo.Stadiums(CityID,TeamID,Seats)
	values(@CityID,@TeamID,@Seats);
end
go

execute addStadiums 1,1,12000;
execute addStadiums 2,2,15600;
execute addStadiums 3,3,20000;
execute addStadiums 4,4,15200;
execute addStadiums 5,5,17600;
execute addStadiums 6,6,11000;
execute addStadiums 7,7,18200;
execute addStadiums 8,8,17600;
execute addStadiums 9,9,16300;
execute addStadiums 10,10,15500;
go
--Related Shops Table
create table RelatedShops(
ID int identity(1,1) primary key,
StadiumID int foreign key references Stadiums(ID));

--Insert RelatedShops Data
insert into RelatedShops(StadiumID)
values (1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);
go
--Jerseys Table
create table Jerseys(
ID int identity(1,1) primary key,
PlayerID int foreign key references Player(PlayerID),
Price float not null);
-- Insert Jerseys Data
go
insert into Jerseys(PlayerID,Price)
values(1,100.0),
(2,123.0),
(3,100.5),
(4,110.0),
(5,100.0),
(6,160.0),
(7,150.0),
(8,100.0),
(9,115.0),
(10,100.0),
(11,125.0),
(12,130.0),
(13,115.0),
(14,105.0),
(15,117.0),
(16,113.0),
(17,120.0),
(18,135.0),
(19,125.0),
(20,115.0),
(21,110.0),
(22,105.0);
go
--Orders Table
create table Orders(
ID int identity(1,1) primary key,
JerseyID int foreign key references Jerseys(ID),
ShopID int foreign key references RelatedShops(ID));

--Insert Orders Data
insert into Orders(JerseyID,ShopID)
values(1,1),
(1,2),
(2,1),
(3,2),
(1,10),
(3,1),
(2,3),
(10,1),
(5,7),
(2,2);

create table FanClub(
ClubID int identity(1,1) primary key,
TeamID int foreign key references Team(TeamID),
ClubName varchar(255) not null);
-- Insert FanClub Values
INSERT FanClub(TeamID, ClubName)
values(1, 'Net Rippers'),
(2, 'Basket Hounds'),
(3, 'D-Fence'),
(4, 'Upcourt Funk Me Up'),
(5, 'Spare Balls'),
(6, 'Balls to the Wall'),
(8, 'The Ball Boyz'),
(9, 'Jazz Me Up'),
(10, 'Droolers and Dribblers');

create table Refree(
RefreeID int identity(1,1) primary key,
RefreeFirstName varchar(255) not null,
RefreeLastName varchar(255) not null);
-- Insert Refree Values
INSERT Refree(RefreeFirstName, RefreeLastName)
VALUES ('Ray', 'Acosta'),
('Brandon', 'Adair'),
('Mitchell', 'Ervin'),
('Kane', 'Fitzgerald'),
('Mark', 'Lindsay'),
('Matt', 'Boland'),
('Tony', 'Brown'),
('John', 'Butler'),
('James', 'Capers'),
('Derrick', ' Collins');


create table Game(
GameID int identity(1,1) primary key,
HomeID int foreign key references Team(TeamID),
GuestID int foreign key references Team(TeamID),
DateTimes datetime not null,
HomeScore int not null,
GuestScore int not null,
CityID int foreign key references City(CityID),
Refree int foreign key references Refree(RefreeID));
-- Insert Game Values
INSERT Game(HomeID, GuestID, DateTimes, HomeScore, GuestScore, CityID, Refree)
VALUES (1, 2, 2020-10-12, 78, 69, 1, 1),
(2, 1, 2020-10-13, 87, 78, 2, 2),
(3, 4, 2020-10-14, 78, 69, 3, 3),
(4, 3, 2020-10-15, 98, 75, 4, 4),
(5, 6, 2020-10-16, 95, 102, 5, 5),
(6, 5, 2020-10-17, 76, 99, 6, 6),
(7, 8, 2020-10-18, 102, 88, 7, 7),
(8, 7, 2020-10-19, 105, 98, 8, 8),
(9, 10, 2020-10-20, 93, 85, 9, 9),
(10, 9, 2020-10-21, 68, 76, 10, 10);


create table PlayerPerformance(
GameID int foreign key references Game(GameID),
PlayerID int foreign key references Player(PlayerID),
Score int,
Rebound int,
Assistance int
primary key(GameID,PlayerID));
-- Insert PlayerPerformance Values
INSERT PlayerPerformance(GameID, PlayerID, Score, Rebound, Assistance)
VALUES (1, 1, 48, 12, 3),
(1, 2, 30, 9, 5),
(1, 3, 35, 8, 14),
(1, 4, 34, 7, 5),
(2, 1, 45, 15, 3),
(2, 2, 33, 13, 2),
(2, 3, 47, 16, 11),
(2, 4, 40, 10, 9),
(3, 5, 46, 13, 10),
(3, 6, 32, 10, 7),
(3, 7, 40, 15, 8),
(3, 8, 29, 7, 11),
(4, 5, 40, 18, 8),
(4, 6, 35, 12, 9),
(4, 7, 50, 17, 11),
(4, 8, 48, 11, 9),
(5, 9, 55, 16, 13),
(5, 10, 40, 14, 9),
(5, 11, 60, 18, 4),
(5, 12, 42, 12, 6),
(6, 9, 46, 13, 10),
(6, 10, 30, 12, 16),
(6, 11, 49, 15, 10),
(6, 12, 50, 11, 9),
(7, 13, 62, 19, 10),
(7, 14, 40, 12, 6),
(7, 15, 58, 14, 11),
(7, 16, 30, 15, 12),
(8, 13, 50, 21, 8),
(8, 14, 48, 13, 5),
(8, 15, 65, 18, 14),
(8, 16, 40, 14, 6),
(9, 17, 50, 15, 4),
(9, 18, 43, 10, 10),
(9, 19, 46, 14, 16),
(9, 20, 39, 12, 15),
(10, 17, 46, 16, 3),
(10, 18, 30, 14, 6),
(10, 19, 38, 17, 3),
(10, 20, 30, 11, 8);


create table HallOfFame(
PlayerID int foreign key references Player(PlayerID) primary key,
PlayerName varchar(255) not null,
NominatedTime Datetime not null);
insert HallOfFame(PlayerID,PlayerName,NominatedTime)
values(11,'KOBE BRYANT',2020),
(12,'TIM DUNCAN',2020),
(13,'KEVIN GARNETT',2020),
(14,'EDDIE SUTTON',2020),
(15,'RUDY TOMJANOVICH',2020),
(16,'TAMIKA CATCHINGS',2020),
(17,'KIM MULKEY',2020),
(18,'BARBARA STEVENS',2020),
(19,'Vlade Divac',2019),
(20,'Sidney Moncrief',2019);

create table Manager(
ManagerID int identity(1,1) primary key,
PlayerID int foreign key references Player(PlayerID),
ManagerFirstName varchar(255) not null,
MangagerLastName varchar(255) not null);
insert Manager(PlayerID,ManagerFirstName,MangagerLastName)
values(1,'Travis',' Schlenk'),
(2,'Brad', 'Stevens'),
(3,'Sean',' Marks'),
(4,'Mitch',' Kupchak'),
(5,'Marc',' Eversley'),
(6,'Koby',' Altman'),
(7,'Nico',' Harrison'),
(8,'Calvin',' Booth'),
(9,'Troy',' Weaver'),
(10,'Bob',' Myers');


--TransferOrder Table
create table TransferOrder(
TransferID int identity(1,1) primary key,
ManagerID int foreign key references Manager(ManagerID),
PlayerID int foreign key references Player(PlayerID),
TransferAmounts float,
TransferDate datetime);
INSERT TransferOrder(ManagerID,PlayerID,TransferAmounts,TransferDate)
values(1,1,12.9,2002-10-20),
(2,2,10.9,2000-09-09),
(3,3,13.7,2003-08-19),
(4,4,1.2,2007-07-08),
(5,5,1.6,2019-01-02),
(6,6,5.8,2018-07-16),
(7,7,10.6,2005-01-23),
(8,8,8.9,2008-09-06),
(9,9,9.6,2007-07-09),
(10,10,2.1,2016-03-28);

--SponsorOffer Table
create table SponsorOffer(
SponsorOfferID int identity(1,1) primary key,
SponsorFirstName varchar(255) not null,
SponsorLastName varchar(255) not null,
TransferID int foreign key references TransferOrder(TransferID));
insert SponsorOffer(SponsorFirstName,SponsorLastName,TransferID)
values('Aditya','Agarwal',1),
('Akshit','Badyal',2),
('Haotian','Chen',3),
('Yuxi','Chen',4),
('Siddhant','Dube',5),
('Xiaoya','Gao',6),
('Zhenqi','Gao',7),
('Andrew','Le',8),
('Jenna','Losensky',9),
('Keer','Ma',10);

--Audiance Table
create table Audiance(
AudianceID int identity(1,1) primary key,
AudianceFirstName varchar(255) not null,
AudianceLastName varchar(255) not null,
AudiancePhone varchar(255) not null,
AudianceEmail varchar(255) not null);
insert Audiance(AudianceFirstName,AudianceLastName,AudiancePhone,AudianceEmail)
values('Mudit','Bafna','8573219564','11799311178@gmail.com'),
('Jone','Bleakney','8573219566','Jon123456@gmail.com'),
('Jitesh','Chhabrani','832178456372','Chha7883@gmail.com'),
('Joseph','Feeney','8263739275','Joseds@gmail.com'),
('Ruopu','Gao','43723748238','ywueis@gmail,com'),
('Nitech','Gupta','8573219776','199711Gup@qq.com'),
('Thomas','Howsll','8823834728','11799331382@qq.com'),
('Klara','Juliusson','2343123443','12312423sdsc@gmail.com'),
('Kaiwen','Liu','3483257834','sfbuuefi9998@gamil.com'),
('Jenna','Mallas','3776627383','sug387e837@gmail.com');

--Tickets Table
create table Tickets(
TicketsID int identity(1,1) primary key,
AudianceID int foreign key references Audiance(AudianceID),
GameID int foreign key references Game(GameID));
insert Tickets(AudianceID,GameID)
values(1,1),
(1,2),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);



-- Computed Column
go
if exists(select 1
	from sys.columns
	where name='SalesVolume'
	and OBJECT_ID=OBJECT_ID('[dbo].[Jerseys]'))
alter table dbo.Jerseys drop column [SalesVolume];

if OBJECT_ID(N'fn_calSalesVolume',N'FN') IS NOT NULL
drop function dbo.fn_calSalesVolume

go
create function fn_calSalesVolume(@jerseyID INT)
returns int
as
begin
	declare @salesVolume int=
		(select isnull(count(o.ID),0) from Jerseys j
		left join Orders o
		on j.ID=o.JerseyID
		where j.ID=@jerseyID
		group by j.ID);
	return @salesVolume;
end
go

--Add Column
alter table Jerseys
add SalesVolume as (dbo.fn_calSalesVolume(ID))
go

--CONSTRAINT
--If a player has match that get less than 5 points, he will not be inducted into the Hall of Fame
GO

CREATE FUNCTION CheckBehavior (@PID int)
RETURNS int
AS
BEGIN
   DECLARE @Count int=0;
   SELECT @Count = COUNT(GameID) 
          FROM PlayerPerformance
          WHERE PlayerID = @PID
          AND Score < 5 ;
   RETURN @Count;
END;

GO
-- Add table-level CHECK constraint based on the new function for the Reservation table
ALTER TABLE HallOfFame ADD CONSTRAINT BanFame CHECK (dbo.CheckBehavior(PlayerID) = 0);



--view1
--Function: View all players on each team
GO 
CREATE OR ALTER VIEW dbo.checkAllPlayers
AS
select Team.TeamName,Player.PlayerFirstName,Player.PlayerLastName
from Team 
right join Player 
on Player.TeamID=Team.TeamID;






--view2
--Function: View the tickets and games someone has bought by name
GO
create or alter view dbo.audiancetickets
as
select A.AudianceFirstName as FirstName,A.AudianceLastName as LastName,A.AudiancePhone as Phone, T.TicketsID, T.GameID
From dbo.Audiance A
left join dbo.Tickets T
on A.AudianceID=T.AudianceID
-- where A.AudianceFirstName='Mudit' and A.AudianceLastName='Bafna'

GO

-- view3 
-- Score Board
go
create or alter view dbo.Scoreboard
as
select (p.PlayerFirstName+' '+p.PlayerLastName)as Player,isnull(cast(sum(pp.Score)*1.0/count(pp.GameID)*1.0 as decimal(3,1)),0) as avgScore,rank() over(order by sum(pp.Score)*1.0/count(pp.GameID)*1.0 desc) as rnk
from Player p
left join PlayerPerformance pp
on p.PlayerID=pp.PlayerID
group by p.PlayerID,p.PlayerFirstName,p.PlayerLastName
go

-- view4
-- Rebound Board
go
create or alter view dbo.Reboundboard
as
select (p.PlayerFirstName+' '+p.PlayerLastName)as Player,isnull(cast(sum(pp.Rebound)*1.0/count(pp.GameID)*1.0 as decimal(3,1)),0) as avgRebound,rank() over(order by sum(pp.Rebound)*1.0/count(pp.GameID)*1.0 desc) as rnk
from Player p
left join PlayerPerformance pp
on p.PlayerID=pp.PlayerID
group by p.PlayerID,p.PlayerFirstName,p.PlayerLastName
go

--view5 
-- Assitant Board
go
create or alter view dbo.Assistboard
as
select (p.PlayerFirstName+' '+p.PlayerLastName)as Player,isnull(cast(sum(pp.Assistance)*1.0/count(pp.GameID)*1.0 as decimal(3,1)),0) as avgAssist,rank() over(order by sum(pp.Assistance)*1.0/count(pp.GameID)*1.0 desc) as rnk
from Player p
left join PlayerPerformance pp
on p.PlayerID=pp.PlayerID
group by p.PlayerID,p.PlayerFirstName,p.PlayerLastName
go

--view5 
--Team Stands Board
go
create or alter view dbo.Standing
as
select t.TeamName, count(case when (t.TeamID=g.GuestID and g.GuestScore>g.HomeScore) or(t.TeamID=g.HomeID and g.HomeScore>g.GuestScore) then 1 else null end) as wins,
rank() over(order by count(case when (t.TeamID=g.GuestID and g.GuestScore>g.HomeScore) or(t.TeamID=g.HomeID and g.HomeScore>g.GuestScore) then 1 else null end) desc) as rnk
from Team t
left join Game g
on t.TeamID=g.GuestID or t.TeamID=g.HomeID
group by t.TeamID,t.TeamName
go

