--CREATE TABLE FACT_PRODUCTSALESTARGET
CREATE OR REPLACE TABLE Fact_SRCSalesTarget(
    DimStoreID INT CONSTRAINT FK_DimStoreID FOREIGN KEY REFERENCES Dim_Store(DimStoreID) --Foreign Key
    ,DimResellerID INT CONSTRAINT FK_DimResellerID FOREIGN KEY REFERENCES Dim_Reseller(DimResellerID) --Foreign Key
    ,DimChannelID INT CONSTRAINT FK_DimChannelID FOREIGN KEY REFERENCES Dim_Channel(DimChannelID) --Foreign Key
    ,DimTargetDateID INT CONSTRAINT FK_DimTargetDateID FOREIGN KEY REFERENCES Dim_Date(Date_Pkey) --Foreign Key
    ,SalesTargetAmount FLOAT NOT NULL
);

SELECT * FROM Fact_SRCSalesTarget;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Fact_ProductSalesTarget;

--Load rows from Dim_Store, Dim_Reseller, Dim_Channel, Dim_Date
INSERT INTO Fact_SRCSalesTarget
(
    NVL(Dim_Store.DimStoreID, -1) AS DimStoreID
    ,NVL(Dim_Reseller.DimResellerID, -1) AS DimResellerID
    ,NVL(Dim_Channel.DimChannelID, -1) AS DimChannelID
    ,DimTargetDateID
    ,SalesTargetAmount
)
	SELECT DISTINCT
        Dim_Store.DimStoreID AS DimStoreID
        ,Dim_Reseller.DimResellerID AS DimResellerID
        ,Dim_Channel.DimChannelID AS DimChannelID
        ,Dim_Date.Date_Pkey AS DimTargetDateID
        ,Stage_TargetDataChannel.TargetSalesAmount AS SalesTargetAmount
	FROM Stage_TargetDataChannel
    INNER JOIN Dim_Channel ON
    Dim_Channel.ChannelName = 
    CASE 
        WHEN Stage_TargetDataChannel.ChannelName = 'Online' THEN 'On-line' ELSE Stage_TargetDataChannel.ChannelName 
    END
    INNER JOIN Dim_Reseller ON
    Dim_Reseller.ResellerName = Stage_TargetDataChannel.TargetName
    INNER JOIN Dim_Store ON
    Dim_Store.StoreNumber = 
    CASE
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 5' then 5
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 8' then 8
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 10' then 10
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 21' then 21
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 34' then 34
        WHEN Stage_TargetDataChannel.TargetName = 'Store Number 39' then 39
        ELSE TRUE
    END
    LEFT JOIN Dim_Date ON
    Dim_Date.Year = Stage_TargetDataChannel.Year
--15330 results
SELECT * FROM Fact_SRCSalesTarget;