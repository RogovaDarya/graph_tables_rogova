USE master;

DROP DATABASE IF EXISTS CoffeeHouse;
GO

CREATE DATABASE CoffeeHouse;
GO

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
	(1, N'���� ������'),
	(2, N'����� ��������'),
	(3, N'��������� ��������'),
	(4, N'��������� ������'),
	(5, N'������ ��������'),
	(6, N'���� �������'),
	(7, N'������ �������'),
	(8, N'����� ���������'),
	(9, N'������� �������'),
	(10, N'����� ���������'),
	(11, N'������� ������'),
	(12, N'������� ��������'),
	(13, N'����� ��������'),
	(14, N'���� ������'),
	(15, N'��������� ��������'),
	(16, N'��������� �������'),
	(17, N'���� �������'),
	(18, N'����� ����������'),
	(19, N'������ �������'),
	(20, N'����� �����'),
	(21, N'������ ������'),
	(22, N'��������� ��������'),
	(23, N'������� ��������'),
	(24, N'������� ������'),
	(25, N'���� ��������'),
	(26, N'���� �������'),
	(27, N'������ �������'),
	(28, N'����� ���������'),
	(29, N'������� �������'),
	(30, N'����� ��������');
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
  (1, N'�����', N'������� �������'), 
  (2, N'������', N'���������� �������'), 
  (3, N'�������', N'����������� �������'), 
  (4, N'�������', N'��������� �������'), 
  (5, N'������', N'����������� �������'), 
  (6, N'�����', N'��������� �������'), 
  (7, N'����������', N'��������� �������'),
  (8, N'�������', N'������� �������'),
  (9, N'������', N'���������� �������'),
  (10, N'����', N'��������� �������');
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
  (1, N'�����������', N'�������', N'�����'),
  (2, N'�������� ���', N'�������', N'�����'),
  (3, N'����-����', N'�������', N'�����'),
  (4, N'����������', N'�������', N'�����'),
  (5, N'����-�������', N'�������', N'������'),
  (6, N'����-����', N'�������', N'������'),
  (7, N'����-�����', N'�������', N'�������'),
  (8, N'����-�����', N'�������', N'�������'),
  (9, N'�������� ����', N'�������', N'�����'),
  (10, N'����-�����', N'�������', N'����');
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
  (1, N'Myloverberry', N'�����'),
  (2, N'Paragraph', N'�����'),
  (3, N'LoveMyrr', N'�����'),
  (4, N'CoffeeMouse', N'�������'),
  (5, N'Stories', N'�������'),
  (6, N'Varka', N'�������'),
  (7, N'Cofix', N'������'),
  (8, N'Lavazza', N'������'),
  (9, N'Nofilters', N'������'),
  (10, N'Memories', N'������'),
  (11, N'�����', N'�������'),
  (12, N'������', N'�������'),
  (13, N'�������', N'�����'),
  (14, N'�����', N'�����'),
  (15, N'������������', N'������'),
  (16, N'���������', N'����������'),
  (17, N'Hotfix', N'����');
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

-- � ��� ������ ���� ������
SELECT empl1.name + N' ������ � ' + empl2.name AS Level1
, empl2.name + N' ������ � ' + empl3.name AS Level2
FROM Employee AS empl1
, FriendOf AS friend1
, Employee AS empl2
, FriendOf AS friend2
, Employee AS empl3
WHERE MATCH(empl1-(friend1)->empl2-(friend2)->empl3)
AND empl1.name = N'���� ������';

-- ��� �������� ������ ����� �������
SELECT empl2.name AS empl
, Cafe.name AS cafe
FROM Employee AS empl1
, Employee AS empl2
, FriendOf
, WorksIn
, Cafe
WHERE MATCH(empl1-(FriendOf)->empl2-(WorksIn)->Cafe)
AND empl1.name = N'���� ������';

-- ������ ����������� ����� Paragraph
SELECT cafe.name + N' ����������� � ' + GrainSupplier.name AS Deliver
FROM Cafe AS cafe
, DeliversFrom
, GrainSupplier
WHERE MATCH(cafe-(DeliversFrom)->GrainSupplier)
AND cafe.name = N'Paragraph';

-- � ����� ������� ��������� ������� Cofix
SELECT cafe.name + N' ��������� � ' + City.region AS LocationRegion
FROM Cafe AS cafe
, LocatedIn
, City
WHERE MATCH(cafe-(LocatedIn)->City)
AND cafe.name = N'Cofix';

-- � ����� �������� ��������� �������, � ������� �������� ������ ����� �������
SELECT N'������� ' + cafe.name + N', � ������� �������� ' 
	+ empl2.name + N', ��������� � ' + city.region AS Loc
FROM Employee AS empl1
, FriendOf 
, Employee AS empl2
, WorksIn 
, Cafe as cafe
, LocatedIn
, City AS city
WHERE MATCH(empl1-(FriendOf)->empl2-(WorksIn)->cafe-(LocatedIn)->city)
AND empl1.name = N'���� ������';

-- � ����� ������� ���� �� �������� ���� ������
-- ������ ������������ ���-�� ������ ����� ������
SELECT empl1.name AS EmplName
, STRING_AGG(empl2.name, '->') WITHIN GROUP (GRAPH PATH) AS Friends
, empl2cafe.name
FROM Employee AS empl1
, FriendOf FOR PATH AS fo
, Employee FOR PATH AS empl2
, WorksIn AS wi
, Cafe AS empl2cafe
WHERE MATCH(SHORTEST_PATH(empl1(-(fo)->empl2){1,3}) AND LAST_NODE(empl2)-(wi)->empl2cafe)
AND empl1.name = N'���� ������';

-- � ��� ��� ����� �� ������������� ����� �������� ����� ����� ������
SELECT empl1.name AS EmplName
, STRING_AGG(empl2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM Employee AS empl1
, FriendOf FOR PATH AS fo
, Employee FOR PATH AS empl2
WHERE MATCH(SHORTEST_PATH(empl1(-(fo)->empl2)+))
AND empl1.name = N'����� ��������';

-- ���� ������
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

---- ���������� �� ��������� ����� ����� � ���� �����
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
--        N'���� �����',
--		N'������ �����') AS [Type of city]
--FROM dbo.GrainSupplier AS GS,
--     dbo.Cafe AS Cafe,
--	 dbo.DeliversFrom AS DF
--WHERE MATCH (Cafe-(DF)->GS);
