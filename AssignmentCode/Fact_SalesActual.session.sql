--CREATE TABLE FACT_SALESACTUAL
CREATE OR REPLACE TABLE Fact_SalesActual(
    DimProductID INTEGER CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
    ,DimStoreID INTEGER CONSTRAINT FK_DimStoreID FOREIGN KEY REFERENCES Dim_Store(DimStoreID) --Foreign Key
    ,DimResellerID INTEGER CONSTRAINT FK_DimResellerID FOREIGN KEY REFERENCES Dim_Reseller(DimResellerID) --Foreign Key
    ,DimCustomerID INTEGER CONSTRAINT FK_DimCustomerID FOREIGN KEY REFERENCES Dim_Customer(DimCustomerID) --Foreign Key
    ,DimChannelID INTEGER CONSTRAINT FK_DimChannelID FOREIGN KEY REFERENCES Dim_Channel(DimChannelID) --Foreign Key
    ,DimSaleDateID NUMBER(9) CONSTRAINT FK_DimTargetDateID FOREIGN KEY REFERENCES Dim_Date(Date_Pkey) --Foreign Key
    ,DimLocationID INTEGER CONSTRAINT FK_DimLocationID FOREIGN KEY REFERENCES Dim_Location(DimLocationID) --Foreign Key
    ,SourceSalesHeaderID INTEGER NOT NULL
    ,SourceSalesDetailID INTEGER NOT NULL
    ,SaleAmount FLOAT NOT NULL
    ,SaleQuantity FLOAT NOT NULL
    ,SaleUnitPrice FLOAT NOT NULL
    ,SaleExtendedCost FLOAT NOT NULL
    ,SaleTotalProfit FLOAT NOT NULL
);

SELECT * FROM Fact_SalesActual;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Fact_ProductSalesTarget;

--Load rows from Dim_Product, Dim_Store, Dim_Reseller, Dim_Customer, Dim_Channel, Dim_Date, Dim_Location
INSERT INTO Fact_SalesActual
(
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
)
	SELECT DISTINCT
        NVL(Dim_Product.DimProductID, -1) AS DimProductID
        ,NVL(Dim_Store.DimStoreID, -1) AS DimStoreID
        ,NVL(Dim_Reseller.DimResellerID, -1) AS DimResellerID
        ,NVL(Dim_Customer.DimCustomerID, -1) AS DimCustomerID 
        ,NVL(Dim_Channel.DimChannelID, -1)AS DimChannelID
        ,Dim_Date.Date_Pkey AS DimSaleDateID
        ,NVL(Dim_Location.DimLocationID, -1) AS DimLocationID
        ,Stage_SalesHeader.SalesHeaderID AS SourceSalesHeaderID
        ,Stage_SalesDetail.SalesDetailID AS SourceSalesDetailID
        ,Stage_SalesDetail.SalesAmount AS SaleAmount
        ,Stage_SalesDetail.SalesQuantity AS SaleQuantity
        ,Dim_Product.ProductRetailPrice AS SaleUnitPrice
        ,Dim_Product.ProductCost AS SaleExtendedCost
        ,Dim_Product.ProductRetailProfit AS SaleTotalProfit
	FROM Dim_Product
    INNER JOIN Stage_SalesDetail ON
    Stage_SalesDetail.ProductID = Dim_Product.SourceProductID
    INNER JOIN Stage_SalesHeader ON
    Stage_SalesHeader.SalesHeaderID = Stage_SalesDetail.SalesHeaderID
    LEFT JOIN Dim_Customer ON
    Dim_Customer.SourceCustomerID = Stage_SalesHeader.CustomerID
    LEFT JOIN Dim_Reseller ON
    Dim_Reseller.SourceResellerID = Stage_SalesHeader.ResellerID
    LEFT JOIN Dim_Store ON
    Dim_Store.SourceStoreID = Stage_SalesHeader.StoreID
    INNER JOIN Dim_Channel ON
    Dim_Channel.SourceChannelID = Stage_SalesHeader.ChannelID
    LEFT JOIN Dim_Date ON
    Dim_Date.Date = TO_DATE(Stage_SalesHeader.Date, 'MM/DD/YY')
    INNER JOIN Dim_Location ON
    Dim_Location.DimLocationID = Dim_Store.DimLocationID

SELECT * FROM Fact_SalesActual;
--66900 results