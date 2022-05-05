--CREATE TABLE DIM_PRODUCT
CREATE OR REPLACE TABLE Dim_Product(
    DimProductID INT IDENTITY(1,1) CONSTRAINT PK_DimProductID PRIMARY KEY NOT NULL --Surrogate Key
    ,Address VARCHAR(255) NOT NULL
    ,City VARCHAR(255) NOT NULL
    ,PostalCode VARCHAR(255) NOT NULL
    ,State_Province VARCHAR(255) NOT NULL
    ,Country VARCHAR(50) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Product

--Load unknown members
INSERT INTO Dim_Product
(
    Species
    ,Classification
    ,Designation
    ,SkinHues
    ,HairColors
    ,EyeColors
    ,Language
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
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Product;
--Load Location
INSERT INTO Dim_Product
(
    Address
    ,City
    ,PostalCode
    ,State_Province
    ,Country
)
	SELECT 
    Address
    ,City
    ,PostalCode
    ,StateProvince AS State_Province
    ,Country
     
	FROM STAGE_RESELLER

SELECT * FROM Dim_Product

INSERT INTO Dim_Product
(
    Address
    ,City
    ,PostalCode
    ,State_Province
    ,Country
)
	SELECT 
    Address
    ,City
    ,PostalCode
    ,StateProvince AS State_Province
    ,Country
     
	FROM STAGE_Customer

SELECT * FROM Dim_Product