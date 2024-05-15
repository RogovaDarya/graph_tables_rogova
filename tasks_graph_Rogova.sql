USE master;

DROP DATABASE IF EXISTS CoffeeHouse;
CREATE DATABASE CoffeeHouse;

USE CoffeeHouse;
GO

CREATE TABLE Employee
(
	id INT NOT NULL PRIMARY KEY,
	name NVARCHAR(50) NOT NULL
) AS NODE;
GO

INSERT INTO Employee (id, name)
VALUES
	(1, N'Иван Иванов'),
	(2, N'Мария Смирнова'),
	(3, N'Александр Кузнецов'),
	(4, N'Екатерина Попова'),
	(5, N'Максим Васильев'),
	(6, N'Анна Петрова'),
	(7, N'Сергей Соколов'),
	(8, N'Ольга Михайлова'),
	(9, N'Дмитрий Новиков'),
	(10, N'Елена Морозилко'),
	(11, N'Алексей Иванов'),
	(12, N'Наталья Смирнова'),
	(13, N'Игорь Кузнецов'),
	(14, N'Анна Попова'),
	(15, N'Александр Васильев'),
	(16, N'Екатерина Петрова'),
	(17, N'Иван Соколов'),
	(18, N'Ольга Михайлович'),
	(19, N'Сергей Новиков'),
	(20, N'Елена Мороз'),
	(21, N'Михаил Иванов'),
	(22, N'Екатерина Смирнова'),
	(23, N'Алексей Кузнецов'),
	(24, N'Наталья Попова'),
	(25, N'Иван Васильев'),
	(26, N'Анна Петрова'),
	(27, N'Сергей Соколов'),
	(28, N'Ольга Михайлова'),
	(29, N'Дмитрий Новиков'),
	(30, N'Елена Морозова');
GO

SELECT * 
FROM Employee;
GO

CREATE TABLE City
(
	id INT NOT NULL PRIMARY KEY,
	name NVARCHAR(30) NOT NULL,
	region NVARCHAR(30) NOT NULL
) AS NODE;
GO

INSERT INTO City (id, name, region)
VALUES
  (1, N'Минск', N'Минская область'), 
  (2, N'Гомель', N'Гомельская область'), 
  (3, N'Могилев', N'Могилевская область'), 
  (4, N'Витебск', N'Витебская область'), 
  (5, N'Гродно', N'Гродненская область'), 
  (6, N'Брест', N'Брестская область'), 
  (7, N'Барановичи', N'Брестская область'),
  (8, N'Борисов', N'Минская область'),
  (9, N'Мозырь', N'Гомельская область'),
  (10, N'Орша', N'Витебская область');
GO

SELECT * 
FROM City;
GO

CREATE TABLE GrainSupplier
(
	id INT NOT NULL PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	grainsType NVARCHAR(50) NOT NULL,
	city NVARCHAR(30) NOT NULL
) AS NODE;
GO

INSERT INTO GrainSupplier (id, name, grainsType, city)
VALUES
  (1, N'Кофеэкспорт', N'Арабика', N'Минск'),
  (2, N'Кофейный мир', N'Робуста', N'Минск'),
  (3, N'Кофе-Хаус', N'Арабика', N'Брест'),
  (4, N'Кофеиновый', N'Арабика', N'Минск'),
  (5, N'Кофе-Престиж', N'Робуста', N'Гомель'),
  (6, N'Кофе-Люкс', N'Арабика', N'Гродно'),
  (7, N'Кофе-Элита', N'Арабика', N'Борисов'),
  (8, N'Кофе-Профи', N'Робуста', N'Витебск'),
  (9, N'Кофейный рейн', N'Арабика', N'Минск'),
  (10, N'Кофе-Трейд', N'Робуста', N'Орша');
GO

SELECT * 
FROM GrainSupplier;
GO

CREATE TABLE Cafe
(
	id INT NOT NULL PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	city NVARCHAR(30) NOT NULL
) AS NODE;
GO

INSERT INTO Cafe (id, name, city)
VALUES
  (1, N'Myloverberry', N'Минск'),
  (2, N'Paragraph', N'Минск'),
  (3, N'LoveMyrr', N'Минск'),
  (4, N'CoffeeMouse', N'Могилев'),
  (5, N'Stories', N'Витебск'),
  (6, N'Varka', N'Могилев'),
  (7, N'Cofix', N'Гомель'),
  (8, N'Lavazza', N'Гомель'),
  (9, N'Nofilters', N'Гродно'),
  (10, N'Memories', N'Гродно'),
  (11, N'Чашка', N'Борисов'),
  (12, N'Сторис', N'Борисов'),
  (13, N'Березка', N'Брест'),
  (14, N'Турка', N'Брест'),
  (15, N'Воспоминания', N'Мозырь'),
  (16, N'КофеСаунд', N'Барановичи'),
  (17, N'Hotfix', N'Орша');
GO

SELECT * 
FROM Cafe;
GO

CREATE TABLE FriendOf AS EDGE;
GO

CREATE TABLE LocatedIn AS EDGE;
GO

CREATE TABLE DeliversFrom AS EDGE;
GO

CREATE TABLE WorksIn AS EDGE;
GO

ALTER TABLE FriendOf ADD CONSTRAINT EC_FriendOf CONNECTION (Employee to Employee);
GO

ALTER TABLE LocatedIn ADD CONSTRAINT EC_LocatedIn CONNECTION (Cafe to City);
GO

ALTER TABLE DeliversFrom ADD CONSTRAINT EC_DeliversFrom CONNECTION (Cafe to GrainSupplier);
GO

ALTER TABLE WorksIn ADD CONSTRAINT EC_WorksIn CONNECTION (Employee to Cafe);
GO

INSERT INTO FriendOf ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Employee WHERE id = 1), 
		(SELECT $node_id FROM Employee WHERE id = 2)),
	((SELECT $node_id FROM Employee WHERE id = 2), 
		(SELECT $node_id FROM Employee WHERE id = 5)),
	((SELECT $node_id FROM Employee WHERE id = 3), 
		(SELECT $node_id FROM Employee WHERE id = 6)),
	((SELECT $node_id FROM Employee WHERE id = 4), 
		(SELECT $node_id FROM Employee WHERE id = 1)),
	((SELECT $node_id FROM Employee WHERE id = 5), 
		(SELECT $node_id FROM Employee WHERE id = 6)),
	((SELECT $node_id FROM Employee WHERE id = 6), 
		(SELECT $node_id FROM Employee WHERE id = 2)),
	((SELECT $node_id FROM Employee WHERE id = 7), 
		(SELECT $node_id FROM Employee WHERE id = 4)),
	((SELECT $node_id FROM Employee WHERE id = 8), 
		(SELECT $node_id FROM Employee WHERE id = 7)),
	((SELECT $node_id FROM Employee WHERE id = 9), 
		(SELECT $node_id FROM Employee WHERE id = 8)),
	((SELECT $node_id FROM Employee WHERE id = 10), 
		(SELECT $node_id FROM Employee WHERE id = 9)),
	((SELECT $node_id FROM Employee WHERE id = 11), 
		(SELECT $node_id FROM Employee WHERE id = 12)),
	((SELECT $node_id FROM Employee WHERE id = 12), 
		(SELECT $node_id FROM Employee WHERE id = 15)),
	((SELECT $node_id FROM Employee WHERE id = 13), 
		(SELECT $node_id FROM Employee WHERE id = 16)),
	((SELECT $node_id FROM Employee WHERE id = 14), 
		(SELECT $node_id FROM Employee WHERE id = 11)),
	((SELECT $node_id FROM Employee WHERE id = 15), 
		(SELECT $node_id FROM Employee WHERE id = 16)),
	((SELECT $node_id FROM Employee WHERE id = 16), 
		(SELECT $node_id FROM Employee WHERE id = 12)),
	((SELECT $node_id FROM Employee WHERE id = 17), 
		(SELECT $node_id FROM Employee WHERE id = 14)),
	((SELECT $node_id FROM Employee WHERE id = 18), 
		(SELECT $node_id FROM Employee WHERE id = 17)),
	((SELECT $node_id FROM Employee WHERE id = 19), 
		(SELECT $node_id FROM Employee WHERE id = 18)),
	((SELECT $node_id FROM Employee WHERE id = 20), 
		(SELECT $node_id FROM Employee WHERE id = 19)),
	((SELECT $node_id FROM Employee WHERE id = 21), 
		(SELECT $node_id FROM Employee WHERE id = 22)),
	((SELECT $node_id FROM Employee WHERE id = 22), 
		(SELECT $node_id FROM Employee WHERE id = 25)),
	((SELECT $node_id FROM Employee WHERE id = 23), 
		(SELECT $node_id FROM Employee WHERE id = 26)),
	((SELECT $node_id FROM Employee WHERE id = 24), 
		(SELECT $node_id FROM Employee WHERE id = 21)),
	((SELECT $node_id FROM Employee WHERE id = 25), 
		(SELECT $node_id FROM Employee WHERE id = 26)),
	((SELECT $node_id FROM Employee WHERE id = 26), 
		(SELECT $node_id FROM Employee WHERE id = 22)),
	((SELECT $node_id FROM Employee WHERE id = 27), 
		(SELECT $node_id FROM Employee WHERE id = 24)),
	((SELECT $node_id FROM Employee WHERE id = 28), 
		(SELECT $node_id FROM Employee WHERE id = 27)),
	((SELECT $node_id FROM Employee WHERE id = 29), 
		(SELECT $node_id FROM Employee WHERE id = 28)),
	((SELECT $node_id FROM Employee WHERE id = 30), 
		(SELECT $node_id FROM Employee WHERE id = 29)),
	((SELECT $node_id FROM Employee WHERE id = 10), 
		(SELECT $node_id FROM Employee WHERE id = 30)),
	((SELECT $node_id FROM Employee WHERE id = 7), 
		(SELECT $node_id FROM Employee WHERE id = 21)),
	((SELECT $node_id FROM Employee WHERE id = 28), 
		(SELECT $node_id FROM Employee WHERE id = 12)),
	((SELECT $node_id FROM Employee WHERE id = 11), 
		(SELECT $node_id FROM Employee WHERE id = 29));
GO

SELECT *
FROM FriendOf;
GO

INSERT INTO LocatedIn ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Cafe WHERE id = 1), 
		(SELECT $node_id FROM City WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 2), 
		(SELECT $node_id FROM City WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 3), 
		(SELECT $node_id FROM City WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 4), 
		(SELECT $node_id FROM City WHERE id = 3)),
	((SELECT $node_id FROM Cafe WHERE id = 5), 
		(SELECT $node_id FROM City WHERE id = 4)),
	((SELECT $node_id FROM Cafe WHERE id = 6), 
		(SELECT $node_id FROM City WHERE id = 3)),
	((SELECT $node_id FROM Cafe WHERE id = 7), 
		(SELECT $node_id FROM City WHERE id = 2)),
	((SELECT $node_id FROM Cafe WHERE id = 8), 
		(SELECT $node_id FROM City WHERE id = 2)),
	((SELECT $node_id FROM Cafe WHERE id = 9), 
		(SELECT $node_id FROM City WHERE id = 5)),
	((SELECT $node_id FROM Cafe WHERE id = 10), 
		(SELECT $node_id FROM City WHERE id = 5)),
	((SELECT $node_id FROM Cafe WHERE id = 11), 
		(SELECT $node_id FROM City WHERE id = 8)),
	((SELECT $node_id FROM Cafe WHERE id = 12), 
		(SELECT $node_id FROM City WHERE id = 8)),
	((SELECT $node_id FROM Cafe WHERE id = 13), 
		(SELECT $node_id FROM City WHERE id = 6)),
	((SELECT $node_id FROM Cafe WHERE id = 14), 
		(SELECT $node_id FROM City WHERE id = 6)),
	((SELECT $node_id FROM Cafe WHERE id = 15), 
		(SELECT $node_id FROM City WHERE id = 9)),
	((SELECT $node_id FROM Cafe WHERE id = 16), 
		(SELECT $node_id FROM City WHERE id = 7)),
	((SELECT $node_id FROM Cafe WHERE id = 17), 
		(SELECT $node_id FROM City WHERE id = 10));
GO

SELECT *
FROM LocatedIn;
GO

INSERT INTO DeliversFrom ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Cafe WHERE id = 1), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 2), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 3), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 1)),
	((SELECT $node_id FROM Cafe WHERE id = 4), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 2)),
	((SELECT $node_id FROM Cafe WHERE id = 5), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 2)),
	((SELECT $node_id FROM Cafe WHERE id = 6), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 4)),
	((SELECT $node_id FROM Cafe WHERE id = 7), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 5)),
	((SELECT $node_id FROM Cafe WHERE id = 8), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 5)),
	((SELECT $node_id FROM Cafe WHERE id = 9), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 6)),
	((SELECT $node_id FROM Cafe WHERE id = 10), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 7)),
	((SELECT $node_id FROM Cafe WHERE id = 11), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 7)),
	((SELECT $node_id FROM Cafe WHERE id = 12), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 3)),
	((SELECT $node_id FROM Cafe WHERE id = 13),
		(SELECT $node_id FROM GrainSupplier WHERE id = 8)),
	((SELECT $node_id FROM Cafe WHERE id = 14), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 9)),
	((SELECT $node_id FROM Cafe WHERE id = 15), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 9)),
	((SELECT $node_id FROM Cafe WHERE id = 16),
		(SELECT $node_id FROM GrainSupplier WHERE id = 10)),
	((SELECT $node_id FROM Cafe WHERE id = 17), 
		(SELECT $node_id FROM GrainSupplier WHERE id = 9));
GO

SELECT *
FROM DeliversFrom;
GO

INSERT INTO WorksIn ($from_id, $to_id)
VALUES
	((SELECT $node_id FROM Employee WHERE id = 1), 
		(SELECT $node_id FROM Cafe WHERE id = 1)),
	((SELECT $node_id FROM Employee WHERE id = 2), 
		(SELECT $node_id FROM Cafe WHERE id = 2)),
	((SELECT $node_id FROM Employee WHERE id = 3), 
		(SELECT $node_id FROM Cafe WHERE id = 3)),
	((SELECT $node_id FROM Employee WHERE id = 4), 
		(SELECT $node_id FROM Cafe WHERE id = 4)),
	((SELECT $node_id FROM Employee WHERE id = 5), 
		(SELECT $node_id FROM Cafe WHERE id = 5)),
	((SELECT $node_id FROM Employee WHERE id = 6), 
		(SELECT $node_id FROM Cafe WHERE id = 6)),
	((SELECT $node_id FROM Employee WHERE id = 7), 
		(SELECT $node_id FROM Cafe WHERE id = 7)),
	((SELECT $node_id FROM Employee WHERE id = 8), 
		(SELECT $node_id FROM Cafe WHERE id = 8)),
	((SELECT $node_id FROM Employee WHERE id = 9), 
		(SELECT $node_id FROM Cafe WHERE id = 8)),
	((SELECT $node_id FROM Employee WHERE id = 10), 
		(SELECT $node_id FROM Cafe WHERE id = 9)),
	((SELECT $node_id FROM Employee WHERE id = 11), 
		(SELECT $node_id FROM Cafe WHERE id = 9)),
	((SELECT $node_id FROM Employee WHERE id = 12), 
		(SELECT $node_id FROM Cafe WHERE id = 10)),
	((SELECT $node_id FROM Employee WHERE id = 13), 
		(SELECT $node_id FROM Cafe WHERE id = 10)),
	((SELECT $node_id FROM Employee WHERE id = 14), 
		(SELECT $node_id FROM Cafe WHERE id = 11)),
	((SELECT $node_id FROM Employee WHERE id = 15), 
		(SELECT $node_id FROM Cafe WHERE id = 11)),
	((SELECT $node_id FROM Employee WHERE id = 16), 
		(SELECT $node_id FROM Cafe WHERE id = 12)),
	((SELECT $node_id FROM Employee WHERE id = 17), 
		(SELECT $node_id FROM Cafe WHERE id = 12)),
	((SELECT $node_id FROM Employee WHERE id = 18), 
		(SELECT $node_id FROM Cafe WHERE id = 13)),
	((SELECT $node_id FROM Employee WHERE id = 19), 
		(SELECT $node_id FROM Cafe WHERE id = 13)),
	((SELECT $node_id FROM Employee WHERE id = 20), 
		(SELECT $node_id FROM Cafe WHERE id = 14)),
	((SELECT $node_id FROM Employee WHERE id = 21), 
		(SELECT $node_id FROM Cafe WHERE id = 14)),
	((SELECT $node_id FROM Employee WHERE id = 22), 
		(SELECT $node_id FROM Cafe WHERE id = 15)),
	((SELECT $node_id FROM Employee WHERE id = 23), 
		(SELECT $node_id FROM Cafe WHERE id = 15)),
	((SELECT $node_id FROM Employee WHERE id = 24), 
		(SELECT $node_id FROM Cafe WHERE id = 15)),
	((SELECT $node_id FROM Employee WHERE id = 25), 
		(SELECT $node_id FROM Cafe WHERE id = 16)),
	((SELECT $node_id FROM Employee WHERE id = 26), 
		(SELECT $node_id FROM Cafe WHERE id = 16)),
	((SELECT $node_id FROM Employee WHERE id = 27), 
		(SELECT $node_id FROM Cafe WHERE id = 16)),
	((SELECT $node_id FROM Employee WHERE id = 28), 
		(SELECT $node_id FROM Cafe WHERE id = 17)),
	((SELECT $node_id FROM Employee WHERE id = 29), 
		(SELECT $node_id FROM Cafe WHERE id = 17)),
	((SELECT $node_id FROM Employee WHERE id = 30), 
		(SELECT $node_id FROM Cafe WHERE id = 17));
GO

SELECT *
FROM WorksIn;
GO

-- С кем дружит Иван Иванов
SELECT empl1.name + N' дружит с ' + empl2.name AS Level1
, empl2.name + N' дружит с ' + empl3.name AS Level2
FROM Employee AS empl1
, FriendOf AS friend1
, Employee AS empl2
, FriendOf AS friend2
, Employee AS empl3
WHERE MATCH(empl1-(friend1)->empl2-(friend2)->empl3)
AND empl1.name = N'Иван Иванов';

-- Где работают друзья Ивана Иванова
SELECT empl2.name AS empl
, Cafe.name AS cafe
FROM Employee AS empl1
, Employee AS empl2
, FriendOf
, WorksIn
, Cafe
WHERE MATCH(empl1-(FriendOf)->empl2-(WorksIn)->Cafe)
AND empl1.name = N'Иван Иванов';

-- Откуда приобритает зерна Paragraph
SELECT cafe.name + N' приобретает в ' + GrainSupplier.name AS Deliver
FROM Cafe AS cafe
, DeliversFrom
, GrainSupplier
WHERE MATCH(cafe-(DeliversFrom)->GrainSupplier)
AND cafe.name = N'Paragraph';

-- В какой области находится кофейня Cofix
SELECT cafe.name + N' находится в ' + City.region AS LocationRegion
FROM Cafe AS cafe
, LocatedIn
, City
WHERE MATCH(cafe-(LocatedIn)->City)
AND cafe.name = N'Cofix';

-- В каких областях находятся кофейни, в которых работают друзья Ивана Иванова
SELECT N'Кофейня ' + cafe.name + N', в которой работает ' 
	+ empl2.name + N', находится в ' + city.region AS Loc
FROM Employee AS empl1
, FriendOf 
, Employee AS empl2
, WorksIn 
, Cafe as cafe
, LocatedIn
, City AS city
WHERE MATCH(empl1-(FriendOf)->empl2-(WorksIn)->cafe-(LocatedIn)->city)
AND empl1.name = N'Иван Иванов';

-- В какой кофейне смог бы работать Иван Иванов
-- пройдя максимальное кол-во друзей своих друзей
SELECT empl1.name AS EmplName
, STRING_AGG(empl2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
, empl2cafe.name
FROM Employee AS empl1
, FriendOf FOR PATH AS fo
, Employee FOR PATH AS empl2
, WorksIn AS wi
, Cafe AS empl2cafe
WHERE MATCH(SHORTEST_PATH(empl1(-(fo)->empl2){1,3}) AND LAST_NODE(empl2)-(wi)->empl2cafe)
AND empl1.name = N'Иван Иванов';

-- С кем еще могла бы познакомиться Мария Смирнова через своих друзей
SELECT empl1.name AS EmplName
, STRING_AGG(empl2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Employee AS empl1
, FriendOf FOR PATH AS fo
, Employee FOR PATH AS empl2
WHERE MATCH(SHORTEST_PATH(empl1(-(fo)->empl2)+))
AND empl1.name = N'Мария Смирнова';

-- граф коллег
--SELECT P1.ID IdFirst
-- , P1.name AS First
-- , CONCAT(N'Friends',P1.id) AS [First image name]
-- , P2.ID AS IdSecond
-- , P2.name AS Second
-- , CONCAT(N'Friends',P2.id) AS [Second image name]
--FROM dbo.Employee AS P1
-- , dbo.FriendOf AS F
-- , dbo.Employee AS P2
--WHERE MATCH (P1-(F)->P2)

---- поставляет ли поставщик зерен зерна в свой город
--SELECT Cafe.ID AS IdCafe,
--	   Cafe.name AS CafeName,
--	   CONCAT(N'Cafe', Cafe.id) AS [Cafe image name],
--       GS.ID AS IdGS,
--       GS.name AS GSName,
--       CONCAT(N'GS', GS.id) AS [GS image name],
--       IIF(GS.city = (
--                SELECT C.name
--                FROM LocatedIn AS LI, dbo.City AS C 
--                WHERE MATCH (Cafe-(LI)->C)
--           ),
--        N'свой город',
--		N'другой город') AS [Type of city]
--FROM dbo.GrainSupplier AS GS,
--     dbo.Cafe AS Cafe,
--	 dbo.DeliversFrom AS DF
--WHERE MATCH (Cafe-(DF)->GS);
