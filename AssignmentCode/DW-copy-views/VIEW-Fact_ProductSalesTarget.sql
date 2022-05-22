CREATE VIEW ViewFact_ProductSalesTarget
    AS
    SELECT
        DimProductID
        ,DimTargetDateID
        ,ProductTargetSalesQuantity
    FROM Fact_ProductSalesTarget