--CREATE TABLE DIM_LOCATION
CREATE OR REPLACE TABLE Dim_Location(
    DimLocationID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimLocationID PRIMARY KEY NOT NULL --Surrogate Key
    ,Address VARCHAR(255) NOT NULL
    ,City VARCHAR(255) NOT NULL
    ,PostalCode VARCHAR(255) NOT NULL
    ,Region VARCHAR(255) NOT NULL
    ,Country VARCHAR(50) NOT NULL
);

SELECT * FROM Dim_Location;
--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Location;

--Load unknown members
INSERT INTO Dim_Location
(
    DimLocationID
    ,Address
    ,City
    ,PostalCode
    ,Region
    ,Country
)
VALUES
( 
    -1
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Location;

--Load rows from reseller, customer, and store
INSERT INTO Dim_Location
(
    Address
    ,City
    ,PostalCode
    ,Region
    ,Country
)
SELECT 
    Address
    ,City
    ,PostalCode
    ,StateProvince AS Region
    ,Country
     
	FROM STAGE_RESELLER

    UNION

    SELECT 
    Address
    ,City
    ,PostalCode
    ,StateProvince AS Region
    ,Country
     
	FROM STAGE_Customer

    UNION

    SELECT 
    Address
    ,City
    ,PostalCode
    ,StateProvince AS Region
    ,Country

    FROM STAGE_Store;

SELECT * FROM Dim_Location;
