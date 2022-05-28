CREATE OR REPLACE SECURE VIEW ViewDim_Product
    AS
    SELECT
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
    FROM Dim_Product