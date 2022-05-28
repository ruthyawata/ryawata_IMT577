CREATE OR REPLACE SECURE VIEW ViewDim_Reseller
    AS
    SELECT
        DimResellerID
        ,DimLocationID
        ,SourceResellerID
        ,ResellerName
        ,ContactName
        ,PhoneNumber
        ,Email
    FROM Dim_Reseller