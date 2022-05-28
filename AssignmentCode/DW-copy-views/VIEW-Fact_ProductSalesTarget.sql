CREATE OR REPLACE SECURE VIEW ViewFact_ProductSalesTarget
    AS
    SELECT
        DimProductID
        ,DimTargetDateID
        ,ProductTargetSalesQuantity
    FROM Fact_ProductSalesTarget