--CREATE TABLE DIM_PRODUCT
CREATE OR REPLACE TABLE Dim_Product(
    DimProductID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimProductID PRIMARY KEY NOT NULL --Surrogate Key
    ,ProductID INTEGER NOT NULL
    ,ProductTypeID INTEGER NOT NULL
    ,ProductCategoryID INTEGER NOT NULL
    ,ProductName VARCHAR(255) NOT NULL
    ,ProductType VARCHAR(255) NOT NULL
    ,ProductCategory VARCHAR(255) NOT NULL
    ,ProductRetailPrice FLOAT NOT NULL
    ,ProductWholesalePrice FLOAT NOT NULL
    ,ProductCost FLOAT NOT NULL
    ,ProductRetailProfit FLOAT NOT NULL
    ,ProductWholesaleUnitProfit FLOAT NOT NULL
    ,ProductProfitMarginUnitPercent FLOAT NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Product;

--Load unknown members
INSERT INTO Dim_Product
(
    DimProductID
    ,ProductID
    ,ProductTypeID
    ,ProductCategoryID
    ,ProductName
    ,ProductType
    ,ProductCategory
    ,ProductRetailPrice
    ,ProductWholesalePrice
    ,ProductCost
    ,ProductRetailProfit
    ,ProductWholesaleUnitProfit
    ,ProductProfitMarginUnitPercent
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
    ,-1
);

SELECT * FROM Dim_Product;

--Load rows from Stage_Product, product type, product category
INSERT INTO Dim_Product
(
    ProductID
    ,ProductTypeID
    ,ProductCategoryID
    ,ProductName
    ,ProductType
    ,ProductCategory
    ,ProductRetailPrice
    ,ProductWholesalePrice
    ,ProductCost
    ,ProductRetailProfit
    ,ProductWholesaleUnitProfit
    ,ProductProfitMarginUnitPercent
)
	SELECT 
    ProductID
    ,ProductTypeID
    ,Stage_ProductType.ProductCategoryID AS ProductCategoryID
    ,Stage_Product.Product AS ProductName
    ,Stage_ProductType.ProductType AS ProductType
    ,Stage_ProductCategory.ProductCategory AS ProductCategory
    ,Stage_Product.Price AS ProductRetailPrice
    ,Stage_Product.WholesalePrice AS ProductWholesalePrice
    ,Stage_Product.Cost AS ProductCost
    ,AS ProductRetailProfit
    --Sales Profit (Quantity × Price) − (Quantity × Cost)
    ,AS ProductWholesaleUnitProfit
    ,AS ProductProfitMarginUnitPercent
    --Profit Margin % of individual products (Price − Cost) ÷ (Price)
     
	FROM Stage_Product
    INNER JOIN Stage_ProductType ON
    Stage_ProductType.ProductTypeID = Stage_Product.ProductTypeID
    INNER JOIN Stage_ProductCategory
    Stage_ProductType.ProductCategoryID = Stage_ProductCategory.ProductCategoryID;

SELECT * FROM Dim_Product;

SELECT 
    Stage_ProductType.ProductCategoryID AS ProductCategoryID
    FROM Stage_Product
    INNER JOIN Stage_ProductType ON
    Stage_ProductType.ProductTypeID = Stage_Product.ProductTypeID;