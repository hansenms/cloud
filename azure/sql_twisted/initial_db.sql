DROP TABLE IF EXISTS dbo.People
CREATE TABLE dbo.People (ID int, LastName varchar(255), FirstName varchar(255));
INSERT INTO dbo.People (ID, LastName, FirstName) VALUES (1, 'Petersen', 'Peter');
INSERT INTO dbo.People (ID, LastName, FirstName) VALUES (2, 'Gates', 'Bill');
INSERT INTO dbo.People (ID, LastName, FirstName) VALUES (3, 'Jobs', 'Steve');
GO
