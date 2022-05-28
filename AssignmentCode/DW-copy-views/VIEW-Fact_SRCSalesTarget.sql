CREATE OR REPLACE SECURE VIEW ViewFact_SRCSalesTarget
    AS
    SELECT
        DimStoreID
        ,DimResellerID
        ,DimChannelID
        ,DimTargetDateID
        ,SalesTargetAmount
    FROM Fact_SRCSalesTarget