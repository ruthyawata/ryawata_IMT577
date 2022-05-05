--CREATE TABLE DIM_CUSTOMER
CREATE OR REPLACE TABLE Dim_Customer(
    DimCustomerID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimCustomerID PRIMARY KEY NOT NULL --Surrogate Key
    ,DimLocationID INTEGER CONSTRAINT FK_DimLocationIDCustomer FOREIGN KEY REFERENCES Dim_Location (DimLocationID) NOT NULL --Foreign Key
    ,CustomerID VARCHAR(255) NOT NULL
    ,CustomerFullName VARCHAR(255) NOT NULL
    ,CustomerFirstName VARCHAR(255) NOT NULL
    ,CustomerLastName VARCHAR(255) NOT NULL
    ,CustomerGender VARCHAR(255) NOT NULL
);

SELECT * FROM Dim_Customer;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Customer;

--Load unknown members
INSERT INTO Dim_Customer
(
    DimCustomerID
    ,DimLocationID
    ,CustomerID
    ,CustomerFullName
    ,CustomerFirstName
    ,CustomerLastName
    ,CustomerGender
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

SELECT * FROM Dim_Customer;

--Load rows from Stage_Customer
INSERT INTO Dim_Customer
(
    DimLocationID
    ,CustomerID
    ,CustomerFullName
    ,CustomerFirstName
    ,CustomerLastName
    ,CustomerGender
)
SELECT 
    Dim_Location.DimLocationID
    ,Stage_Customer.CustomerID as CustomerID
    ,CONCAT(Stage_Customer.FirstName,SPACE(1),Stage_Customer.LastName) AS CustomerFullName
    ,Stage_Customer.FirstName AS FirstName
    ,Stage_Customer.LastName AS LastName
    ,Stage_Customer.Gender AS CustomerGender
FROM Stage_Customer
INNER JOIN Dim_Location ON
Dim_Location.Address = Stage_Customer.Address;

SELECT * FROM Dim_Customer;