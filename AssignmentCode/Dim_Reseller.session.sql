--CREATE TABLE DIM_RESELLER
CREATE OR REPLACE TABLE Dim_Reseller(
    DimResellerID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimResellerID PRIMARY KEY NOT NULL --Surrogate Key
    ,DimLocationID INTEGER CONSTRAINT FK_DimLocationIDCustomer FOREIGN KEY REFERENCES Dim_Location (DimLocationID) NOT NULL --Foreign Key
    ,ResellerID VARCHAR(255) NOT NULL
    ,ResellerName VARCHAR(255) NOT NULL
    ,ContactName VARCHAR(255) NOT NULL
    ,PhoneNumber String NOT NULL
    ,Email VARCHAR(255) NOT NULL
);

SELECT * FROM Dim_Reseller;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Reseller;

--Load unknown members
INSERT INTO Dim_Reseller
(
    DimResellerID
    ,DimLocationID
    ,ResellerID
    ,ResellerName
    ,ContactName
    ,PhoneNumber
    ,Email
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Reseller;

--Load rows from Stage_Reseller
INSERT INTO Dim_Reseller
(
    DimLocationID
    ,ResellerID
    ,ResellerName
    ,ContactName
    ,PhoneNumber
    ,Email
)
SELECT 
    Dim_Location.DimLocationID
    ,Stage_Reseller.ResellerID AS ResellerID
    ,Stage_Reseller.ResellerName AS ResellerName
    ,Stage_Reseller.Contact AS ContactName
    ,Stage_Reseller.PhoneNumber AS PhoneNumber
    ,Stage_Reseller.EmailAddress AS Email
FROM Stage_Reseller
INNER JOIN Dim_Location ON
Dim_Location.Address = Stage_Reseller.Address;

SELECT * FROM Dim_Reseller;