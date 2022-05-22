/***
Business questions for pod 1:
1. Give an overall assessment of stores number 5 and 8’s sales.

How are they performing compared to target? Will they meet their 2014 target?
Should either store be closed? Why or why not?
What should be done in the next year to maximize store profits?

2. Recommend separate 2013 and 2014 bonus amounts for each store if the total bonus pool for 2013 is $500,000 and the total bonus pool for 2014 is $400,000. Base your recommendation on how well the stores are selling Product Types of Men’s Casual and Women’s Casual.

3. Assess product sales by day of the week at stores 5 and 8. What can we learn about sales trends?
Hint: group by aggregate for daily and then it's the average of those days of the week

4. Compare the performance of all stores located in states that have more than one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?
***/


-- View 1: 2013 & 2014 sales targets for stores 5 & 8
CREATE VIEW Store_SalesTarget
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
    WHERE Dim_Store.StoreNumber = 5 OR Dim_Store.StoreNumber = 8
    GROUP BY Dim_Date.Year, Dim_Store.StoreNumber, Fact_SRCSalesTarget.SalesTargetAmount
    ORDER BY Dim_Store.StoreNumber, Dim_Date.Year

-- View 2: 2013 & 2014 actual sales for stores 5 & 8
CREATE VIEW Store_SalesActual
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
        WHERE Dim_Store.StoreNumber = 5 OR Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Date.Year
        ORDER BY Dim_Store.StoreNumber, Dim_Date.Year

-- View 3: All product types sales for all stores
CREATE VIEW ProductType_SalesActual
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
CREATE VIEW MensCasual_SalesTarget
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
CREATE VIEW WomensCasual_SalesTarget
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

-- View 6: Store 5 2013 & 2014 product sales amount for Mens's Casual
CREATE VIEW Store5_MensCasual_SalesActual
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
        AND Dim_Store.StoreNumber = 5
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 7: Store 5 2013 & 2014 product sales amount for Womens's Casual
CREATE VIEW Store5_WomensCasual_SalesActual
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
        AND Dim_Store.StoreNumber = 5
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 8: Store 8 2013 & 2014 product sales amount for Mens's Casual
CREATE VIEW Store8_MensCasual_SalesActual
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
        AND Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 9: Store 8 2013 & 2014 product sales amount for Womens's Casual
CREATE VIEW Store8_WomensCasual_SalesActual
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
        Fact_SalesActual.DimSaleDateID = Dim_Date.Date_Pkey
        WHERE Dim_Product.ProductType LIKE '%Women%Casual%'
        AND Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Product.ProductType, Dim_Date.Year

-- View 10: Product sales by day of the week
CREATE VIEW ProductSales_DayofWeek
    AS
    SELECT DISTINCT
            Dim_Store.StoreNumber
            ,Dim_Date.Day_Abbrev
            ,SUM(Fact_SalesActual.SaleQuantity) AS ProductSales
        FROM Fact_SalesActual
        INNER JOIN Dim_Store ON
        Fact_SalesActual.DimStoreID = DIm_Store.DimStoreID
        INNER JOIN Dim_Date ON
        Fact_SalesActual.DimSaleDateID = Dim_Date.Date_Pkey
        WHERE Dim_Store.StoreNumber = 5 OR Dim_Store.StoreNumber = 8
        GROUP BY Dim_Store.StoreNumber, Dim_Date.Day_Abbrev
        ORDER BY ProductSales DESC

-- View 11: Actual sales of stores by state
CREATE VIEW StoresbyState_Sales
    AS
    SELECT DISTINCT
        Dim_Store.StoreNumber
        ,Dim_Location.Region AS State
        ,Dim_Date.Year
        ,SUM(Fact_SalesActual.SaleAmount) AS SalesActual
    FROM Dim_Store
    INNER JOIN Dim_Location ON
    Dim_Store.DimLocationID = Dim_Location.DimLocationID
    INNER JOIN Fact_SalesActual ON
    Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
    GROUP BY Dim_Store.StoreNumber, State, Dim_Date.Year
    ORDER BY Dim_Store.StoreNumber, State, Dim_Date.Year

-- View 12: Target sales of stores by state
CREATE VIEW StoresbyState_Target
    AS
    SELECT DISTINCT
        Dim_Store.StoreNumber
        ,Dim_Location.Region AS State
        ,Dim_Date.Year
        ,Fact_SRCSalesTarget.SalesTargetAmount AS Target
    FROM Dim_Store
    INNER JOIN Dim_Location ON
    Dim_Store.DimLocationID = Dim_Location.DimLocationID
    INNER JOIN Fact_SRCSalesTarget ON
    Fact_SRCSalesTarget.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SRCSalesTarget.DimTargetDateID
    GROUP BY Dim_Store.StoreNumber, State, Dim_Date.Year, Target
    ORDER BY Dim_Store.StoreNumber, State, Dim_Date.Year, Target