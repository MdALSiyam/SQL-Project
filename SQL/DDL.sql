/*
					        SQL Project Name : Art Gallery Management System
							    Trainee Name : Md. Abdul Latif (Siyam)
						    	  Trainee ID : 1285124      
							        Batch ID : CS/SCSL-M/61/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL

			     -> SECTION 01 :  Created a Database ArtDB
			     -> SECTION 02 :  Created Appropriate Tables with column definition related to the project
			     -> SECTION 03 :  ALTER, DROP AND MODIFY TABLES & COLUMNS
			     -> SECTION 04 :  CREATE CLUSTERED AND NONCLUSTERED INDEX
			     -> SECTION 05 :  CREATE SEQUENCE & ALTER SEQUENCE
			     -> SECTION 06 :  CREATE A VIEW & ALTER VIEW
			     -> SECTION 07 :  CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			     -> SECTION 08 :  CREATE FUNCTIONS
			     -> SECTION 09 :  CREATE TRIGGER (FOR/AFTER TRIGGER)
			     -> SECTION 10 :  CREATE TRIGGER (INSTEAD OF TRIGGER)
				 -> SECTION 11 :  DROP TRIGGER
				 -> SECTION 12 :  DROP FUNCTION
				 -> SECTION 13 :  DROP PROCEDURE
				 -> SECTION 14 :  DROP VIEW
				 -> SECTION 15 :  DROP SEQUENCE

*/





---------- SECTION 01 :  Created a Database ArtDB ---------

USE MASTER
GO
IF DB_ID ('ArtDB') IS NOT NULL
DROP DATABASE ArtDB
GO
CREATE DATABASE ArtDB
ON(
Name=ArtDB_Data_1,
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ArtDB_Data_1.mdf',
Size=25mb,
MaxSize=100mb,
FileGrowth=5%
)
LOG ON(
Name=ArtDB_Log_1,
FileName='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ArtDB_Log_1.ldf',
Size=2mb,
MaxSize=25mb,
FileGrowth=1%
)
GO

----------------------------------------------------------





---------- SECTION 02 :  Created Appropriate Tables with column definition related to the project ----------

USE ArtDB
GO

----- Table 1 -----

CREATE TABLE Customer(
CustomerNo varchar(5) primary key not null,
CustomerFName varchar(25) not null,
CustomerLName varchar(25) not null,
PhoneNo varchar(10) not null
)
GO


----- Table 2 -----

CREATE TABLE Artist(
ArtistNo varchar(5) primary key not null,
ArtistFName varchar(25) not null,
ArtistLName varchar(25) not null,
)
GO


----- Table 3 -----

CREATE TABLE Art(
ArtNo int primary key not null,
Title varchar(50) not null,
ArtistNo varchar(5) REFERENCES Artist(ArtistNo)
)
GO


----- Table 4 -----

CREATE TABLE ArtGallery(
ArtNo int REFERENCES Art(ArtNo),
CustomerNo varchar(5) REFERENCES Customer(CustomerNo),
Primary key (ArtNo, CustomerNo),
Price decimal (18,2) not null,
Discount decimal (18,2) not null
)
GO

-------------------------------------------------------------------------------------------------------------





---------- SECTION 03 :  ALTER, DROP AND MODIFY TABLES & COLUMNS ----------

----- ALTER Table -----

ALTER TABLE ArtGallery
ADD PurchaseDate DATE
GO


----- DROP Table -----

DROP TABLE ArtGallery
GO


----- MODIFY Table -----

ALTER TABLE ArtGallery
ADD Price money
GO

---------------------------------------------------------------------------





---------- SECTION 04 :  CREATE CLUSTERED AND NONCLUSTERED INDEX ----------

----- Non Clustered Index -----

CREATE TABLE ArtGenre (
ID int primary key NONCLUSTERED,
PurchaseDate date,
Genre varchar (10)
)
GO


----- Clustered Index -----

CREATE CLUSTERED INDEX ix_ArtGenre_ID
ON ArtGenre(ID)
GO

---------------------------------------------------------------------------





---------- SECTION 05 :  CREATE SEQUENCE & ALTER SEQUENCE ----------

----- CREATE SEQUENCE -----

CREATE SEQUENCE mySequence
AS INT 
START WITH 10
INCREMENT BY 5
MINVALUE 0
MAXVALUE 100
CYCLE CACHE 10
GO 


----- CREATE TABLE SEQUENCE -----

CREATE TABLE MySequenceTable(
SequenceNo int not null,
SequenceName varchar(50) not null,
)
GO


----- ALTER SEQUENCE -----

ALTER SEQUENCE mySequence
AS INT 
RESTART WITH 50
INCREMENT BY 5
MINVALUE 0
MAXVALUE 100
CYCLE CACHE 10
GO

---------------------------------------------------------------------





---------- SECTION 06 :  CREATE A VIEW & ALTER VIEW ----------

----- Create View -----

USE ArtDB
GO

CREATE VIEW vu_ArtDB
AS
SELECT c.PhoneNo AS 'Customer Phone',
	   c.CustomerNo AS 'Customer No',
	   c.CustomerFName+' '+c.CustomerLName AS 'Customer',
	   ar.ArtistNo AS 'Artist No',
	   ar.ArtistFName+' '+ar.ArtistLName AS 'Artist',
	   a.Title AS 'Art',
	   ag.Price AS 'Price',
	   CAST(ag.Discount*100 AS VARCHAR)+'%' AS 'Discount',
	   (Price*Discount) AS 'Price After Discount'
FROM ArtGallery ag
JOIN Art a
ON ag.ArtNo=a.ArtNo
JOIN Artist ar
ON a.ArtistNo=ar.ArtistNo
JOIN Customer c
ON ag.CustomerNo=c.CustomerNo

GO


----- Alter View -----

ALTER VIEW vu_ArtDB
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT c.PhoneNo AS 'Customer Phone',
	   c.CustomerNo AS 'Customer No',
	   c.CustomerFName+' '+c.CustomerLName AS 'Customer',
	   ar.ArtistNo AS 'Artist No',
	   ar.ArtistFName+' '+ar.ArtistLName AS 'Artist',
	   a.Title AS 'Art',
	   ag.Price AS 'Price',
	   CAST(ag.Discount*100 AS VARCHAR)+'%' AS 'Discount',
	   (Price*Discount) AS 'Price After Discount'
FROM dbo.ArtGallery ag
JOIN dbo.Art a
ON ag.ArtNo=a.ArtNo
JOIN dbo.Artist ar
ON a.ArtistNo=ar.ArtistNo
JOIN dbo.Customer c
ON ag.CustomerNo=c.CustomerNo

GO

----------------------------------------------------------------





---------- SECTION 07 :  CREATE STORED PROCEDURE & ALTER STORED PROCEDURE ----------

USE ArtDB
GO

CREATE PROC sp_CRUDWithOutputReturn
@Statement varchar (10)='',
@ArtistNo varchar(5),
@ArtistFName varchar(25),
@ArtistLName varchar(25),
@Name varchar(10) Output
AS

----- Main Gate -----

BEGIN

----- 1st Door -----

if @Statement='Select'
BEGIN
SELECT * FROM Artist
END


----- 2nd Door -----

if @Statement='Insert'
BEGIN
BEGIN TRAN
BEGIN TRY
INSERT INTO Artist 
(ArtistNo, ArtistFName, ArtistLName)
VALUES
(@ArtistNo, @ArtistFName, @ArtistLName)
COMMIT TRAN
END TRY

BEGIN CATCH
SELECT ERROR_MESSAGE() ErrorMessage
ROLLBACK TRAN
END CATCH
END


----- 3rd Door -----

if @Statement='Update'
BEGIN
UPDATE Artist 
SET ArtistFName=@ArtistFName
WHERE ArtistNo=@ArtistNo
END


----- 4th Door -----

if @Statement='Delete'
BEGIN
DELETE FROM Artist 
WHERE ArtistNo=@ArtistNo
END

----- 5th Door -----

if @Statement='Output'
BEGIN
SELECT @Name=ArtistFName FROM Artist
WHERE ArtistNo=@ArtistNo
END


----- 6th Door -----

if @Statement='Return'
BEGIN
DECLARE @Count int
SELECT @Count=COUNT(ArtistNo) FROM Artist
RETURN @Count
END

END
GO

-----------------------------------------------------------------------------------------





---------- SECTION 08 :  CREATE FUNCTIONS ----------

----- Scaler Function -----

CREATE FUNCTION fn_ScalarFunction (@MemberID as int )
Returns int
AS 
Begin 
Return (@MemberID+10)
end 
GO

--- Justify --- 
--Select dbo.fn_ScalarFunction(100)
--GO


--- Table Valued Function ---

CREATE FUNCTION fn_TableValuedFunction (@ArtNo AS int, @Title AS varchar(50))
RETURNS TABLE
AS 
RETURN(SELECT Title FROM Art WHERE ArtNo > 101)
GO

--SELECT * FROM Art


----- Multi Table Valued Function -----

CREATE Function fn_MultiTableFunction(@price decimal, @discount decimal)
RETURNS @OutputTable table
(ArtNo int, 
CustomerNo varchar(5),
Price decimal,
Discount decimal)
BEGIN
INSERT INTO @OutputTable
SELECT ArtNo, CustomerNo, Price, Discount FROM ArtGallery
WHERE Price>2500
UPDATE @OutputTable SET Price=Price-@price, Discount=Discount+@discount
RETURN;
END
GO

----- Justify -----

--SELECT * FROM fn_MultiTableFunction(500, 5)

-----------------------------------------------------





---------- SECTION 09 :  CREATE TRIGGER (FOR/AFTER TRIGGER) ----------

CREATE TRIGGER trUpdateDelete 
ON ArtGallery FOR UPDATE,DELETE 
AS 
BEGIN 
PRINT 'Update And Delete For This Table is Restricted'
ROLLBACK TRANSACTION
END 
GO
UPDATE ArtGallery SET Discount='100'
DELETE FROM ArtGallery WHERE CustomerNo='15'
GO
-----------------------------------------------------------------------





---------- SECTION 10 :  CREATE TRIGGER (INSTEAD OF TRIGGER) ----------

CREATE TRIGGER InsteadOfInsertTrigger
ON Art
INSTEAD OF INSERT
AS 
BEGIN
	INSERT INTO Art (ArtNo, Title, ArtistNo)
	SELECT ArtNo, Title, ArtistNo
	FROM inserted;
END
GO

-----------------------------------------------------------------------




---------- SECTION 11 :  DROP TRIGGER ----------

DROP TRIGGER InsteadOfInsertTrigger
GO

------------------------------------------------




---------- SECTION 12 :  DROP FUNCTION ----------

DROP FUNCTION fn_MultiTableFunction
GO

-------------------------------------------------




---------- SECTION 13 :  DROP PROCEDURE ----------

DROP PROCEDURE sp_CRUDWithOutputReturn
GO

--------------------------------------------------




---------- SECTION 14 :  DROP VIEW ----------

DROP VIEW vu_ArtDB
GO

---------------------------------------------




---------- SECTION 15 :  DROP SEQUENCE ----------

DROP SEQUENCE MySequenceTable
GO

-------------------------------------------------










-------------------------------------------------- ==========  THE END  ========== --------------------------------------------------