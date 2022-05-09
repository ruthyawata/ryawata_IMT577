/*****************************************
Course: IMT 577
Instructor: Sean Pettersen
IT Session: 7
Date: 11/14/2021
Notes: Create fact tables & load.

Steps:
    1. Create fact tables simple
    2. Create fact tables aggregate
    2. Load Data
*****************************************/
--Clear table for demo
TRUNCATE Fact_Characters;
TRUNCATE Fact_Planets;

--Check that table is clear
SELECT * FROM Fact_Characters;
SELECT * FROM Fact_Planets;

DROP TABLE IF EXISTS Fact_Characters;
DROP TABLE IF EXISTS Fact_Planets;

CREATE TABLE Fact_Characters
(
     DimCharacterID INTEGER CONSTRAINT FK_DimCharacterID FOREIGN KEY REFERENCES Dim_Characters(DimCharacterID) --Foreign Key
	,Height FLOAT
    ,Mass FLOAT
);

--DROP TABLE IF EXISTS Fact_Characters;

CREATE TABLE Fact_Planets
(
	 DimCharacterID INT CONSTRAINT FK_DimCharacterID FOREIGN KEY REFERENCES Dim_Characters(DimCharacterID) --Foreign Key
    ,DimPlanetID INT CONSTRAINT FK_DimPlanetID FOREIGN KEY REFERENCES Dim_Planets(DimPlanetID) --Foreign Key
    ,DimSpeciesID INT CONSTRAINT FK_DimSpeciesID FOREIGN KEY REFERENCES Dim_Species(DimSpeciesID) --Foreign Key
	,RotationPeriod INT
    ,OrbitalPeriod INT
    ,Diameter INT
    ,SurfaceWaterPct FLOAT
    ,Population INT
);

--Insert Simple
INSERT INTO Fact_Characters
	(
		 DimCharacterID
		,Height
		,Mass
	)
	SELECT DISTINCT   
		  Dim_Characters.DimCharacterID
		 ,Stage_StarwarsCharacters.Height
         ,Stage_StarwarsCharacters.Mass
	FROM Stage_StarwarsCharacters
	INNER JOIN Dim_Characters ON
	Dim_Characters.CharacterID = Stage_StarwarsCharacters.CharacterID

--Note that it didn't insert any values for Nulls. There were none. 
--These would be added later if null values are added to the system
    
SELECT * FROM FACT_CHARACTERS	

--Insert Complex
INSERT INTO Fact_Planets
	(
		 DimPlanetID 
        ,DimCharacterID
		,DimSpeciesID
		,RotationPeriod
        ,OrbitalPeriod
        ,Diameter
        ,SurfaceWaterPct
        ,Population
	)
	SELECT DISTINCT  
		   Dim_Planets.DimPlanetID
		  ,Dim_Characters.DimCharacterID
          ,Dim_Species.DimSpeciesID
		  ,Stage_StarwarsPlanets.RotationPeriod
          ,Stage_StarwarsPlanets.OrbitalPeriod
          ,Stage_StarwarsPlanets.Diameter
          ,Stage_StarwarsPlanets.SurfaceWater AS SurfactWaterPct
          ,Stage_StarwarsPlanets.Population
	FROM Stage_StarwarsPlanets
	INNER JOIN Dim_Planets ON
	Dim_Planets.PlanetID = Stage_StarwarsPlanets.PlanetID
	INNER JOIN Dim_Characters ON
	Dim_Characters.Homeworld = Stage_StarwarsPlanets.Name 
    LEFT OUTER JOIN Dim_Species ON
	Dim_Species.Homeworld = Stage_StarwarsPlanets.Name 
    --ORDER BY Dim_Characters.DimCharacterID
    select * from stage_starwarsspecies
    --There are rows missing why? There are 87 rows in the characters table. Why is it only showing 77?
    
SELECT * FROM FACT_PLANETS	

-- Create Fact_Species
CREATE TABLE Fact_Species
(
	 DimCharacterID INT CONSTRAINT FK_DimCharacterID FOREIGN KEY REFERENCES Dim_Characters(DimCharacterID) --Foreign Key
    ,DimSpeciesID INT CONSTRAINT FK_DimSpeciesID FOREIGN KEY REFERENCES Dim_Species(DimSpeciesID) --Foreign Key
	,AvgHeight FLOAT
    ,AvgLifeSpan FLOAT
);
--Insert into Fact_Species
INSERT INTO Fact_Species
	(
		 DimCharacterID
		 ,DimSpeciesID
		,AvgHeight
		,AvgLifeSpan
	)
	SELECT DISTINCT   
		  Dim_Characters.DimCharacterID
		  ,Dim_Species.DimSpeciesID
		 ,Stage_StarwarsSpecies.AverageHeight AS AvgHeight
         ,Stage_StarwarsSpecies.AverageLifeSpan AS AvgLifeSpan
	FROM Stage_StarwarsSpecies
	INNER JOIN Dim_Characters ON
	Dim_Characters.Species = Stage_StarwarsSpecies.Name
	INNER JOIN Dim_Species ON Dim_Species.SpeciesID = Stage_StarwarsSpecies.SpeciesID

SELECT * FROM FACT_SPECIES