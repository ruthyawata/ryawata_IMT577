--CREATE TABLE FACT_PRODUCTSALESTARGET
CREATE OR REPLACE TABLE Fact_ProductSalesTarget(
    DimProductID INT CONSTRAINT FK_DimProductID FOREIGN KEY REFERENCES Dim_Product(DimProductID) --Foreign Key
    ,DimTargetDateID INT CONSTRAINT FK_DimTargetDateID FOREIGN KEY REFERENCES Dim_Date(DatePkey) --Foreign Key
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
        ,Dim_Product.ProductProfitMarginUnitPercent AS ProductProfitMarginUnitPercent
	FROM Dim_Product
	INNER JOIN Dim_Product ON
    -- figure out how to link stage_product with the created date
	Dim_Characters.Species = Stage_StarwarsSpecies.Name
	INNER JOIN Dim_Species ON Dim_Species.SpeciesID = Stage_StarwarsSpecies.SpeciesID

SELECT * FROM Dim_Product;