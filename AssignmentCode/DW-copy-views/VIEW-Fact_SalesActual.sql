CREATE VIEW ViewFact_SalesActual
    AS
    SELECT
        DimProductID
        ,DimStoreID
        ,DimResellerID
        ,DimCustomerID 
        ,DimChannelID
        ,DimSaleDateID
        ,DimLocationID
        ,SourceSalesHeaderID
        ,SourceSalesDetailID
        ,SaleAmount
        ,SaleQuantity
        ,SaleUnitPrice
        ,SaleExtendedCost
        ,SaleTotalProfit
    FROM Fact_SalesActual