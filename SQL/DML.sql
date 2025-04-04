/*
					        SQL Project Name : Art Gallery Management System
							    Trainee Name : Md. Abdul Latif (Siyam)
						    	  Trainee ID : 1285124      
							        Batch ID : CS/scsl-M/61/01 

--------------------------------------------------------------------------------------------------

Table of Contents: DML

		 	     -> SECTION 01 :  INSERT DATA USING INSERT INTO KEYWORD
			     -> SECTION 02 :  SELECT FROM TABLE
				 -> SECTION	03 :  SELECT FROM VIEW
				 -> SECTION	04 :  SELECT INTO
				 -> SECTION	05 :  IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
				 -> SECTION	06 :  INNER JOIN WITH GROUP BY CLAUSE
				 -> SECTION	07 :  OUTER JOIN
				 -> SECTION	09 :  TOP DISTINCT CLAUSE WITH TIES
				 -> SECTION	10 :  COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				 -> SECTION	11 :  BETWEEN, LIKE, IN, NOT IN OPERATOR
				 -> SECTION	12 :  OFFSET FETCH
				 -> SECTION	13 :  AGGREGATE FUNCTIONS
				 -> SECTION	14 :  ROLLUP & CUBE OPERATOR
				 -> SECTION	15 :  INSERT INTO SEQUENCE
				 -> SECTION	16 :  SUB-QUERIES (INNER, CORRELATED)
				 -> SECTION	17 :  EXISTS
			     -> SECTION	18 :  CTE
				 -> SECTION	19 :  MERGE
				 -> SECTION	20 :  IIF, CASE, CHOOSE
				 -> SECTION	21 :  COALESCE & ISNULL
				 -> SECTION 22 :  Wait For Clause
				 -> SECTION	23 :  RANKING FUNCTION
				 -> SECTION	24 :  IF ELSE & PRINT
				 -> SECTION	25 :  GOTO
				 -> SECTION	26 :  WAITFOR
				 -> SECTION	27 :  sp_helptext
				 -> SECTION	28 :  Error Handling With TRY & CATCH BLOCK 
				 -> SECTION	29 :  ALL ANY SOME
				 -> SECTION	30 :  NTILE FUNCTION 
				 -> SECTION	31 :  PERCENTILE RANK
				 -> SECTION	32 :  LAG/LEAD
				 -> SECTION	33 :  DATE FUNCTION
				 -> SECTION	34 :  sp_helpindex
				 -> SECTION	35 :  EXECUTE STORE PROCEDURE
*/





---------- SECTION 01 :  INSERT DATA USING INSERT INTO KEYWORD ----------

USE ArtDB
GO

----- Table 1 -----

INSERT INTO Customer
(CustomerNo, CustomerFName, CustomerLName, PhoneNo)
VALUES
('001', 'JACK', 'COOK', '12345'),
('012', 'TERRY', 'KIM', '23456'),
('037', 'ROY', 'SMITH', '34567')
GO


----- Table 2 -----

INSERT INTO Artist
(ArtistNo, ArtistFName, ArtistLName)
VALUES
('03', 'Carol', 'Chaining'),
('15', 'Dennis', 'Frings')
GO

----- Table 3 -----

INSERT INTO Art
(ArtNo, Title, ArtistNo)
VALUES
(101, 'Laugh with Teeth', '03'),
(102, 'South toward Emerald Sea', '15'),
(103, 'At the Movies', '03')
GO


----- Table 4 -----

INSERT INTO ArtGallery
(ArtNo, CustomerNo, Price, Discount)
VALUES
(101, '001', 7000.00, 0.08),
(102, '001', 2200.00, 0.05),
(103, '001', 5550.00, 0.06),
(102, '012', 2200.00, 0.05),
(101, '037', 7000.00, 0.08)
GO

--------------------------------------------------------------------------





---------- SECTION 02 :  SELECT FROM TABLE ----------

USE ArtDB
GO
SELECT * FROM ArtGallery
GO

------------------------------------------------------





---------- SECTION	03 :  SELECT FROM VIEW ----------

SELECT * FROM vu_ArtDB
GO

-----------------------------------------------------





---------- SECTION	04 :  SELECT INTO ----------

SELECT * INTO Title FROM Art
GO

------------------------------------------------





---------- SECTION	05 :  IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE ----------

SELECT a.Title, ar.ArtistFName , ar.ArtistLName
FROM Art a
JOIN Artist ar 
ON a.ArtistNo = ar.ArtistNo
ORDER BY ar.ArtistNo
GO

SELECT * FROM Art
WHERE ArtNo = 101
GO

----------------------------------------------------------------------------------------





---------- SECTION	06 :  INNER JOIN WITH GROUP BY CLAUSE ----------

SELECT a.Title, 
	   ar.ArtistFName, 
	   ar.ArtistLName,
SUM(ar.ArtistNo) AS 'Artist No' 
FROM Art a
JOIN Artist ar 
ON a.ArtistNo = ar.ArtistNo
GROUP BY (ar.ArtistNo)
GO

--------------------------------------------------------------------





---------- SECTION	07 :  OUTER JOIN ----------

SELECT a.Title, ar.ArtistFName , ar.ArtistLName
FROM Art a
LEFT OUTER JOIN Artist ar 
ON a.ArtistNo = ar.ArtistNo
ORDER BY ar.ArtistNo
GO

-----------------------------------------------





---------- SECTION	08 :  CROSS JOIN ----------

SELECT a.Title, ar.ArtistFName , ar.ArtistLName
FROM Art a
CROSS JOIN Artist ar
GO

-----------------------------------------------





---------- SECTION	09 :  TOP DISTINCT CLAUSE WITH TIES ----------

SELECT DISTINCT TOP 2 Title FROM Art

------------------------------------------------------------------





---------- SECTION	10 :  COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR ----------

--AND

SELECT * FROM Art
WHERE ArtNo = 103 AND Title = 'At the Movies'
GO

--OR 

SELECT * FROM Art
WHERE ArtNo = 103 OR Title = 'At the Movies'
GO

--NOT 

SELECT * FROM Art 
WHERE NOT Title = 'At the Movies'
GO

---------------------------------------------------------------------------------------




---------- SECTION	11 :  LIKE, IN, NOT IN OPERATOR ----------

SELECT * FROM Art
GO

----- Like -----

SELECT * FROM Art
WHERE Title LIKE 'a%'
GO


----- IN -----

SELECT * FROM Art 
WHERE Title IN ('At the Movies')
GO


----- NOT IN -----

SELECT * FROM Art
WHERE Title NOT IN ('B[^P-Z]')
GO

--------------------------------------------------------------





---------- SECTION	12 :  OFFSET FETCH ----------

SELECT *
FROM Art
ORDER BY Title
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;
GO

-------------------------------------------------





---------- SECTION	13 :  AGGREGATE FUNCTIONS ----------

SELECT COUNT(*),
SUM(ArtNo) As SumOfArt,
MAX(ArtNo) As MaxOfArtNo,
MIN(ArtNo) As MinOfArtNo,
AVG(ArtNo) As AvgOfArt
FROM Art
GROUP BY (ArtNo)
GO

--------------------------------------------------------





---------- SECTION  14 :  ROLLUP & CUBE OPERATOR ----------

----- ROLLUP -----

SELECT  ArtNo, 
COUNT(*) AS CountNo
FROM Art
GROUP BY ROllUP(ArtNo)
GO


----- CUBE -----

SELECT  ArtNo, 
COUNT(*) AS CountNo
FROM Art
GROUP BY CUBE(ArtNo)
GO

-----------------------------------------------------------





---------- SECTION	15 :  INSERT INTO SEQUENCE ----------

INSERT INTO MySequenceTable
(SequenceNo, SequenceName)
VALUES 
(NEXT VALUE FOR mySequence, 'First value is inserted'),
(NEXT VALUE FOR mySequence, 'Second value is inserted')
GO

---------------------------------------------------------





---------- SECTION	16 :  SUB-QUERIES (INNER, CORRELATED) ----------

--SELECT * FROM Art
--SELECT * FROM Artist

-- Sub Queries

SELECT ArtNo, Title,
	(SELECT COUNT(*) FROM Art a WHERE ArtNo = a.ArtNo) AS CountArt
FROM Art;
GO


-- Co-Related Sub Queries 

SELECT ArtistNo, ar.ArtistFName, ar.ArtistLName,
  (SELECT Title FROM Art a WHERE ArtNo = a.ArtNo) AS ArtTitle,
  (SELECT ArtistNo FROM Artist ar WHERE ArtistNo = ar.ArtistNo) AS ArtistID
FROM Artist ar
WHERE ArtistNo = (SELECT ArtistNo FROM Artist WHERE ar.ArtistFName = 'Carol');
GO

---------------------------------------------------------------------





---------- SECTION	17 :  EXISTS ----------

SELECT ArtNo, Title
FROM Art a
WHERE EXISTS (
SELECT 1
FROM Artist ar
WHERE a.ArtistNo = a.ArtistNo
);
GO

-------------------------------------------





---------- SECTION	18 :  CTE----------

WITH ArtPurchase AS (
  SELECT 
    a.ArtNo,
    a.Title,
    ar.ArtistFName,
    ar.ArtistLName
FROM Art a
INNER JOIN Artist ar 
ON a.ArtistNo = a.ArtistNo
)
SELECT * FROM ArtPurchase;
GO

---------------------------------------





---------- SECTION	19 :  MERGE ----------

MERGE Art AS TARGET
    USING Artist AS SOURCE
    ON (TARGET.ArtNo = SOURCE.ArtistNo)

    WHEN MATCHED
         AND TARGET.Title <> SOURCE.ArtistFName
         OR TARGET.Title <> SOURCE.ArtistLName

   
    THEN UPDATE
         SET TARGET.Title = SOURCE.ArtistFName,
         TARGET.Title = SOURCE.ArtistLName
     
   
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (ArtistNo, Title, ArtistNo)          
         VALUES (SOURCE.ArtistNo, SOURCE.ArtistFName, SOURCE.ArtistLName)

   
    WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
	GO

------------------------------------------





---------- SECTION	20 :  IIF, CASE, CHOOSE ----------

--SELECT * FROM Art
--SELECt * FROM Artist

----- IIF ----

SELECT ArtNo,
IIF(ArtNo>0,'we have it','We do not have it ') AS Result 
FROM Art
GO 


----- CHOOSE -----

SELECT ArtNo,
CHOOSE(ArtNo,'1st','2nd','3rd','4th','6th')
FROM Art
GO


----- CASE -----

SELECT ArtNo, Title,
CASE
    WHEN ArtNo <= 101 THEN 'Old'
    WHEN ArtNo BETWEEN 100 AND 105 THEN 'Recent'
    WHEN ArtNo >= 105 THEN 'New'
    ELSE 'Unknown'
END AS Category
FROM Art;
GO

-------------------------------------------------------






---------- SECTION	21 :  COALESCE & ISNULL ----------

----- COALESCE -----

SELECT COALESCE(ArtNo,'Arts') AS Art_No, SUM(ArtNo) AS SumArt FROM Art
GROUP BY (ArtNo)
GO


----- ISNULL -----

SELECT * FROM Art
WHERE Title is null
GO

------------------------------------------------------





---------- SECTION  22 :  Wait For Clause ----------

PRINT 'HELLO'
WAITFOR DELAY '00:00:03'
PRINT 'GOOD LUCK'
GO

----------------------------------------------------




---------- SECTION	23 :  RANKING FUNCTION (RANK, DENSE RANK) ----------
 
Select RANK() OVER (Order by ArtistNo) AS ArtistRank,
DENSE_RANK() OVER (Order by ArtistNo) AS DenseRank,
ArtistNo, ArtistFName+' '+ArtistLName As CustomerName
From Artist
GO

------------------------------------------------------------------------





---------- SECTION	24 :  IF ELSE & PRINT ----------

DECLARE @x INT = 10;
IF @x > 5
PRINT 'x is greater than 5'
GO

----------------------------------------------------





---------- SECTION	25 :  GOTO ----------

DECLARE @Counter INT = 0;

PRINT 'Starting loop';

WHILE @Counter < 10
BEGIN
    SET @Counter = @Counter + 1;
    IF @Counter = 5
    GOTO Label;
    PRINT @Counter;
END

Label:
PRINT 'Jumped to Label'
GO

-----------------------------------------





---------- SECTION	26 :  WAITFOR ----------

----- Initial Run -----

SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM ArtGallery
GO


----- Wait 1 Hour -----

WAITFOR DELAY '01:00:00'


----- Second Run -----

SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM ArtGallery
GO


----- Wait 1 Hour -----

WAITFOR DELAY '01:00:00';

----- Third Run -----

SELECT GETDATE() AS 'Run Time', COUNT(*) AS 'Number Of System Processes' FROM ArtGallery
GO

--------------------------------------------





---------- SECTION	27 :  sp_helptext ----------

USE ArtDB
GO
EXEC sp_helptext vu_ArtDB
GO

------------------------------------------------





---------- SECTION	28 :  Error Handling With TRY & CATCH BLOCK  ----------

BEGIN TRY 

DECLARE @a int ,@b int, @c int
set @a = 50
set @b =0
set @c = @a/@b 

PRINT @c
END TRY 
BEGIN CATCH 
PRINT 'you can not divide any number by zero '
PRINT ERROR_MESSAGE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
PRINT ERROR_LINE()
RAISERROR(16,6,1)
END CATCH 
GO

--------------------------------------------------------------------------




---------- SECTION 29 :  ANY, SOME, ALL ----------

----- ANY -----

IF 1>ANY(SELECT ArtNo FROM Art)
PRINT 'Yes'
ELSE 
PRINT 'NO'
GO


----- SOME -----

IF 1>SOME(SELECT ArtNo FROM Art)
PRINT 'Yes'
ELSE 
PRINT 'NO'
GO


----- ALL -----

IF 1>ALL(SELECT ArtNo FROM Art)
PRINT 'Yes'
ELSE 
PRINT 'NO'
GO

---------------------------------------------------




---------- SECTION	30 :  NTILE FUNCTION ----------

SELECT ArtistNo, ArtistFName+' '+ArtistLName AS 'Artist Name',
NTILE(2) OVER (ORDER BY ArtistNo) AS Title2,
NTILE(3) OVER (ORDER BY ArtistNo) AS Title3,
NTILE(4) OVER (ORDER BY ArtistNo) AS Title4
FROM Artist
GO
-----
---------------------------------------------------




---------- SECTION	31 :  PERCENTILE RANK ----------

SELECT ArtNo, Price, PERCENT_RANK()
OVER (PARTITION BY price ORDER BY ArtNo) AS PercentileRank
FROM ArtGallery
GO

----------------------------------------------------




---------- SECTION	32 :  LAG & LEAD ----------

----- LAG -----

SELECT  ArtNo, Price, LAG ( Price, 1, 0) 
OVER (PARTITION BY ArtNo ORDER BY ArtNo)
AS LastSale
FROM ArtGallery
GO


----- LEAD -----

SELECT  ArtNo, Price, LEAD ( Price, 1, 0) 
OVER (PARTITION BY ArtNo ORDER BY ArtNo)
AS LastSale
FROM ArtGallery
GO

----------------------------------------------





---------- SECTION	33 :  DATE FUNCTION ----------

SELECT PurchaseDate, DATEPART(DAY,PurchaseDate) AS DayPart
FROM ArtGallery

SELECT PurchaseDate, DATEADD(MONTH,2,PurchaseDate) AS NewDate
FROM ArtGallery

SELECT PurchaseDate, DATEDIFF(YEAR,PurchaseDate,GETDATE()) AS YearDifference
FROM ArtGallery

SELECT PurchaseDate, DATEDIFF(DAY,PurchaseDate,GETDATE()) AS DayDifference
FROM ArtGallery

SELECT PurchaseDate, DATENAME(DAY,PurchaseDate) DAY 
FROM ArtGallery

SELECT PurchaseDate, DATENAME(YEAR,PurchaseDate) YEAR 
FROM ArtGallery

SELECT PurchaseDate, DATENAME(QUARTER,PurchaseDate) QUARTER
FROM ArtGallery

GO

-----------------------------------------------------




---------- SECTION	34 :  sp_helpindex ----------

EXEC sp_helpindex ArtGenre
GO

-------------------------------------------------




---------- SECTION	35 :  EXECUTE STORE PROCEDURE ----------

EXEC sp_CRUDWithOutputReturn
'Select', '', '', '', ''

EXEC sp_CRUDWithOutputReturn
'Insert', '05', 'Siyam', 'Khan', ''

EXEC sp_CRUDWithOutputReturn
'Update', '05', 'Latif', 'Khan', ''

EXEC sp_CRUDWithOutputReturn
'Delete', '05', '', '', ''

DECLARE @AName varchar(10)
EXEC sp_CRUDWithOutputReturn
'Output', '03', '', '', @AName OUTPUT
PRINT @AName

DECLARE @ReturnCount int
EXEC @ReturnCount= sp_CRUDWithOutputReturn
'Return','','','', ''
PRINT @ReturnCount

GO

-------------------------------------------------------------










-------------------------------------------------- ==========  THE END  ========== --------------------------------------------------