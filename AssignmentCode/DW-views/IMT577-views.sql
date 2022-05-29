-- View 1: 2013 & 2014 sales targets
CREATE OR REPLACE SECURE VIEW Store_SalesTarget
    AS
    SELECT DISTINCT
        Dim_Store.StoreNumber
        ,Dim_Date.Year
        ,Fact_SRCSalesTarget.SalesTargetAmount AS Target
    FROM Dim_Store
    INNER JOIN Fact_SRCSalesTarget ON
    Fact_SRCSalesTarget.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SRCSalesTarget.DimTargetDateID
    GROUP BY Dim_Date.Year, Dim_Store.StoreNumber, Fact_SRCSalesTarget.SalesTargetAmount
    ORDER BY Dim_Store.StoreNumber, Dim_Date.Year

-- View 2: 2013 & 2014 actual sales
CREATE OR REPLACE SECURE VIEW Store_SalesActual
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Date.Year
            ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
        FROM Fact_SalesActual 
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
        GROUP BY Dim_Store.StoreNumber, Dim_Date.Year
        ORDER BY Dim_Store.StoreNumber, Dim_Date.Year

-- View 3: All product types sales for all stores
CREATE OR REPLACE SECURE VIEW ProductType_SalesActual
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Product.ProductType
            ,Dim_Date.Year
            ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Product ON
        Fact_SalesActual.DimProductID = Dim_Product.DimProductID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year
        ORDER BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 4: 2013 & 2014 product sales targets for Mens's Casual 
CREATE OR REPLACE SECURE VIEW MensCasual_SalesTarget
    AS
    SELECT DISTINCT
            Dim_Product.ProductType
            ,Dim_Date.Year
            ,Fact_ProductSalesTarget.ProductTargetSalesQuantity AS TargetQuantity
        FROM Dim_Product
        INNER JOIN Fact_ProductSalesTarget ON
        Fact_ProductSalesTarget.DimProductID = Dim_Product.DimProductID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_ProductSalesTarget.DimTargetDateID
        WHERE Dim_Product.ProductType LIKE '%Men%Casual%'

-- View 5: 2013 & 2014 product sales targets for Womens's Casual 
CREATE OR REPLACE SECURE VIEW WomensCasual_SalesTarget
    AS
    SELECT DISTINCT
            Dim_Product.ProductType
            ,Dim_Date.Year
            ,Fact_ProductSalesTarget.ProductTargetSalesQuantity AS TargetQuantity
        FROM Dim_Product
        INNER JOIN Fact_ProductSalesTarget ON
        Fact_ProductSalesTarget.DimProductID = Dim_Product.DimProductID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_ProductSalesTarget.DimTargetDateID
        WHERE Dim_Product.ProductType LIKE '%Women%Casual%'

-- View 6: 2013 & 2014 product sales amount for Mens's Casual
CREATE OR REPLACE SECURE VIEW MensCasual_SalesActual
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Product.ProductType
            ,Dim_Date.Year
            ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Product ON
        Fact_SalesActual.DimProductID = Dim_Product.DimProductID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
        WHERE Dim_Product.ProductType LIKE '%Men%Casual%'
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 7: 2013 & 2014 product sales amount for Womens's Casual
CREATE OR REPLACE SECURE VIEW WomensCasual_SalesActual
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Product.ProductType
            ,Dim_Date.Year
            ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Product ON
        Fact_SalesActual.DimProductID = Dim_Product.DimProductID
        INNER JOIN Dim_Date ON
        Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
        WHERE Dim_Product.ProductType LIKE '%Women%Casual%'
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 8: Product sales by day of the week
CREATE OR REPLACE SECURE VIEW ProductSales_DayofWeek
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Date.Day_Abbrev
            ,SUM(Fact_SalesActual.SaleAmount) AS ProductSales
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Date ON
        Fact_SalesActual.DimSaleDateID = Dim_Date.Date_Pkey
        WHERE Dim_Store.StoreNumber = 5 OR Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Date.Day_Abbrev
        ORDER BY ProductSales DESC

-- View 9: Actual sales of stores by state
CREATE OR REPLACE SECURE VIEW StoresbyState_ActualSales
    AS
    SELECT DISTINCT
        Dim_Store.StoreNumber
        ,Dim_Location.Region AS State
        ,Dim_Location.City
        ,Dim_Location.PostalCode AS ZipCode
        ,Dim_Date.Year
        ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
    FROM Dim_Store
    INNER JOIN Dim_Location ON
    Dim_Store.DimLocationID = Dim_Location.DimLocationID
    INNER JOIN Fact_SalesActual ON
    Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
    GROUP BY Dim_Store.StoreNumber, State, City, ZipCode, Dim_Date.Year
    ORDER BY Dim_Store.StoreNumber, State, City, ZipCode, Dim_Date.Year

-- View 10: Target sales of stores by state
CREATE OR REPLACE SECURE VIEW StoresbyState_Target
    AS
    SELECT DISTINCT
        Dim_Store.StoreNumber
        ,Dim_Location.Region AS State
        ,Dim_Location.PostalCode AS ZipCode
        ,Dim_Date.Year
        ,Fact_SRCSalesTarget.SalesTargetAmount AS Target
    FROM Dim_Store
    INNER JOIN Dim_Location ON
    Dim_Store.DimLocationID = Dim_Location.DimLocationID
    INNER JOIN Fact_SRCSalesTarget ON
    Fact_SRCSalesTarget.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SRCSalesTarget.DimTargetDateID
    GROUP BY Dim_Store.StoreNumber, State, ZipCode, Dim_Date.Year, Target
    ORDER BY Dim_Store.StoreNumber, State, ZipCode, Dim_Date.Year, Target

-- View 11 Product sales by day
 CREATE OR REPLACE SECURE VIEW ProductSalesType_DayofWeek
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Product.ProductType
            ,Dim_Date.Day_Abbrev
            ,SUM(Fact_SalesActual.SaleAmount) AS ProductSales
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
        INNER JOIN Dim_Date ON
        Fact_SalesActual.DimSaleDateID = Dim_Date.Date_Pkey
        INNER JOIN Dim_Product ON
        Fact_SalesActual.DimProductID = Dim_Product.DimProductID
        WHERE Dim_Store.StoreNumber = 5 OR Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Day_Abbrev
        ORDER BY ProductSales DESC