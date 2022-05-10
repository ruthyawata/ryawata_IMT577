--CREATE TABLE FACT_PRODUCTSALESTARGET
CREATE OR REPLACE TABLE Fact_SRCSalesTarget(
    DimProductID INT CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
    ,DimStoreID INT CONSTRAINT FK_DimStoreID FOREIGN KEY REFERENCES Dim_Store(DimStoreID) --Foreign Key
    ,DimResellerID INT CONSTRAINT FK_DimResellerID FOREIGN KEY REFERENCES Dim_Reseller(DimResellerID) --Foreign Key
    ,DimCustomerID INT CONSTRAINT FK_DimCustomerID FOREIGN KEY REFERENCES Dim_Customer(DimCustomerID) --Foreign Key
    ,DimChannelID INT CONSTRAINT FK_DimChannelID FOREIGN KEY REFERENCES Dim_Channel(DimChannelID) --Foreign Key
    ,DimSaleDateID INT CONSTRAINT FK_DimTargetDateID FOREIGN KEY REFERENCES Dim_Date(Date_Pkey) --Foreign Key
    ,DimLocationID INT CONSTRAINT FK_DimLocationID FOREIGN KEY REFERENCES Dim_Location(DimLocationID) --Foreign Key
    ,SalesTargetAmount FLOAT NOT NULL
);

SELECT * FROM Fact_SRCSalesTarget;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Fact_ProductSalesTarget;

--Load rows from Dim_Product, Dim_Date
INSERT INTO Fact_SRCSalesTarget
(
    DimProductID
    ,DimStoreID
    ,DimResellerID
    ,DimCustomerID 
    ,DimChannelID
    ,DimSaleDateID
    ,DimLocationID
    ,SalesTargetAmount
)
	SELECT DISTINCT
        Dim_Product.DimProductID AS DimProductID
        ,Dim_Store.DimStoreID AS DimStoreID
        ,Dim_Reseller.DimResellerID AS DimResellerID
        ,Dim_Customer_DimCustomerID AS DimCustomerID 
        ,Dim_Channel.DimChannelID AS DimChannelID
        ,Dim_Date.Date_Pkey AS DimSaleDateID
        ,Dim_Location.DimLocationID AS DimLocationID
        ,Stage_TargetDataChannel.TargetSalesAmount AS SalesTargetAmount
	FROM Stage_TargetDataChannel
    INNER JOIN Dim_Channel ON
    Dim_Channel.ChannelName = Stage_TargetDataChannel.ChannelName
    INNER JOIN 

SELECT * FROM Fact_SRCSalesTarget;