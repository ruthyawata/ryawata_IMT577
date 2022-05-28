CREATE OR REPLACE SECURE VIEW ViewDim_Location
    AS
    SELECT
        DimLocationID
        ,Address
        ,City
        ,PostalCode
        ,Region
        ,Country
    FROM Dim_Location