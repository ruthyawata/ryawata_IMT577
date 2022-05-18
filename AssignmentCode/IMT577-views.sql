/***
View 1 - store sales vs target
view 2 - bonus based on product sales
view 3 - sales by day of week for products
view 4 - state-wide sales performance

1. Give an overall assessment of stores number 5 and 8’s sales.

How are they performing compared to target? Will they meet their 2021 target?
Should either store be closed? Why or why not?
What should be done in the next year to maximize store profits?
2. Recommend separate 2020 and 2021 bonus amounts for each store if the total bonus pool for 2020 is $500,000 and the total bonus pool for 2021 is $400,000. Base your recommendation on how well the stores are selling Product Types of Men’s Casual and Women’s Casual.

3. Assess product sales by day of the week at stores 5 and 8. What can we learn about sales trends?

4. Compare the performance of all stores located in states that have more than one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?
***/
CREATE VIEW ProductSales
AS
    SELECT DISTINCT
    Dim_Store.StoreNumber
    ,Dim_Date.Year
    ,Fact_SRCSalesTarget.SalesTargetAmount
    ,SUM(Fact_SalesActual.SaleTotalProfit) AS Amount
    FROM Dim_Store
    INNER JOIN Fact_SRCSalesTarget ON
    Fact_SRCSalesTarget.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Fact_SalesActual on
    Fact_SalesActual.DimStoreID = Dim_Store.DimStoreID
    INNER JOIN Dim_Date ON
    Dim_Date.Date_Pkey = Fact_SalesActual.DimSaleDateID
    WHERE Dim_Store.StoreNumber = 5
    GROUP BY Dim_Date.Year, Dim_Store.StoreNumber, Fact_SRCSalesTarget.SalesTargetAmount
    ORDER BY Dim_Store.StoreNumber, Dim_Date.Year
-- group by aggregate for daily and then it's the average of those days of the week
select sum(saleamount) 
from Fact_SalesActual 
WHERE DimStoreID = 1 AND DimSaleDateID LIKE '2013%'
select SalesTargetAmount from Fact_SRCSalesTarget WHERE DimStoreID = 1 GROUP BY SalesTargetAmount

SELECT SUM(Fact_SalesActual.SaleTotalProfit) AS Profit
FROM Fact_SalesActual 
INNER JOIN 
WHERE DimStoreID = 1 
AND DimSaleDateID LIKE '2013%'
sele