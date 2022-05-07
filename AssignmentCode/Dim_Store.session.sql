--CREATE TABLE DIM_STORE
CREATE OR REPLACE TABLE Dim_Store(
    DimStoreID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimStoreID PRIMARY KEY NOT NULL --Surrogate Key
    ,DimLocationID INTEGER CONSTRAINT FK_DimLocationIDCustomer FOREIGN KEY REFERENCES Dim_Location (DimLocationID) NOT NULL --Foreign Key
    ,SourceStoreID INTEGER NOT NULL
    ,StoreNumber INTEGER NOT NULL
    ,StoreManager VARCHAR(255) NOT NULL
);

SELECT * FROM Dim_Store;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Store;

--Load unknown members
INSERT INTO Dim_Store
(
    DimStoreID
    ,DimLocationID
    ,SourceStoreID
    ,StoreNumber
    ,StoreManager
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,-1
    ,'Unknown'
);

SELECT * FROM Dim_Store;

--Load rows from Stage_Store
INSERT INTO Dim_Store
(
    DimLocationID
    ,SourceStoreID
    ,StoreNumber
    ,StoreManager
)
SELECT 
    Dim_Location.DimLocationID
    ,Stage_Store.StoreID AS SourceStoreID
    ,Stage_Store.StoreNumber AS StoreNumber
    ,Stage_Store.StoreManager AS StoreManager
FROM Stage_Store
INNER JOIN Dim_Location ON
Dim_Location.Address = Stage_Store.Address;

SELECT * FROM Dim_Store;