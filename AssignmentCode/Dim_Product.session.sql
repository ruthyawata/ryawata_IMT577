--CREATE TABLE DIM_PRODUCT
CREATE OR REPLACE TABLE Dim_Product(
    DimProductID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimProductID PRIMARY KEY NOT NULL --Surrogate Key
    ,SourceProductID INTEGER NOT NULL
    ,SourceProductTypeID INTEGER NOT NULL
    ,SourceProductCategoryID INTEGER NOT NULL
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

SELECT * FROM Dim_Product;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Product;

--Load unknown members
INSERT INTO Dim_Product
(
    DimProductID
    ,SourceProductID
    ,SourceProductTypeID
    ,SourceProductCategoryID
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
    SourceProductID
    ,SourceProductTypeID
    ,SourceProductCategoryID
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
    Stage_Product.ProductID AS SourceProductID
    ,Stage_Product.ProductTypeID AS SourceProductTypeID
    ,Stage_ProductType.ProductCategoryID AS SourceProductCategoryID
    ,Stage_Product.Product AS ProductName
    ,Stage_ProductType.ProductType AS ProductType
    ,Stage_ProductCategory.ProductCategory AS ProductCategory
    ,Stage_Product.Price AS ProductRetailPrice
    ,Stage_Product.WholesalePrice AS ProductWholesalePrice
    ,Stage_Product.Cost AS ProductCost
    ,SUM(Stage_Product.Price - Stage_Product.Cost) AS ProductRetailProfit
    ,SUM(Stage_Product.WholesalePrice - Stage_Product.Cost) AS ProductWholesaleUnitProfit
    ,ROUND(SUM((Stage_Product.Price - Stage_Product.Cost) / Stage_Product.Price), 2)  AS ProductProfitMarginUnitPercent
	FROM Stage_Product
    INNER JOIN Stage_ProductType ON Stage_ProductType.ProductTypeID = Stage_Product.ProductTypeID
    INNER JOIN Stage_ProductCategory ON Stage_ProductCategory.ProductCategoryID = Stage_ProductType.ProductCategoryID
    GROUP BY Stage_Product.ProductID, Stage_Product.ProductTypeID, Stage_ProductType.ProductCategoryID, ProductName, ProductType, ProductCategory, ProductRetailPrice, ProductWholesalePrice, ProductCost;

SELECT * FROM Dim_Product;