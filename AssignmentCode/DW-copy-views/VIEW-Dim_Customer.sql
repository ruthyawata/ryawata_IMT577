CREATE VIEW ViewDim_Customer
    AS
    SELECT
        DimCustomerID
        ,DimLocationID
        ,SourceCustomerID
        ,CustomerFullName
        ,CustomerFirstName
        ,CustomerLastName
        ,CustomerGender
        ,EmailAddress
        ,PhoneNumber
    FROM Dim_Customer