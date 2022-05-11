--CREATE TABLE FACT_PRODUCTSALESTARGET
CREATE OR REPLACE TABLE Fact_ProductSalesTarget(
    DimProductID INT CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
    ,DimTargetDateID INT CONSTRAINT FK_DimTargetDateID FOREIGN KEY REFERENCES Dim_Date(Date_Pkey) --Foreign Key
    ,ProductTargetSalesQuantity FLOAT NOT NULL
);

SELECT * FROM Fact_ProductSalesTarget;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Fact_ProductSalesTarget;

--Load rows from Dim_Product, Dim_Date
INSERT INTO Fact_ProductSalesTarget
(
    DimProductID
    ,DimTargetDateID
    ,ProductProfitMarginUnitPercent
)
	SELECT DISTINCT
        Dim_Product.DimProductID AS DimProductID
        ,Dim_Date.Date_Pkey AS DimTargetDateID
        ,Stage_TargetDataProduct.SalesQuantityTarget AS ProductTargetSalesQuantity
	FROM Stage_TargetDataProduct
    INNER JOIN Dim_Product ON
    Dim_Product.SourceProductID = Stage_TargetDataProduct.ProductID
    LEFT JOIN Dim_Date ON
    Dim_Date.Year = Stage_TargetDataProduct.Year
    --17520 results?
SELECT * FROM Fact_ProductSalesTarget;