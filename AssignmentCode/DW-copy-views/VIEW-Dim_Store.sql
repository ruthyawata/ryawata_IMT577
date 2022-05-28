CREATE OR REPLACE SECURE VIEW ViewDim_Store
    AS
    SELECT
        DimStoreID
        ,DimLocationID
        ,SourceStoreID
        ,StoreNumber
        ,StoreManager
    FROM Dim_Store