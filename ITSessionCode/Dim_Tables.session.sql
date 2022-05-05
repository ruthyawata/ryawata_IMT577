/*****************************************
Course: IMT 577
Instructor: Sean Pettersen
IT Session: 6
Date: 11/14/2021
Notes: Create dimension tables & load.

Steps:
    1. Create dimension tables
    2. Load Unknown Members
    3. Load Data
*****************************************/
--Clear table for demo
TRUNCATE Dim_Characters;

--Check that table is clear
SELECT * FROM Dim_Characters;

USE SCHEMA public
--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Characters(
    DimCharacterID INT IDENTITY(1,1) CONSTRAINT PK_DimCharacterID PRIMARY KEY NOT NULL --Surrogate Key
	,CharactersID INTEGER NOT NULL --Natural Key
    ,Name VARCHAR(255) NOT NULL
    ,HairColor VARCHAR(255) NOT NULL
    ,SkinHue VARCHAR(255) NOT NULL
    ,EyeColor VARCHAR(255) NOT NULL
    ,Gender VARCHAR(50) NOT NULL
    ,Homeworld VARCHAR(255) NOT NULL
    ,Species VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Characters

--Load unknown members
INSERT INTO Dim_Characters
(
     DimCharacterID
	,CharactersID
    ,Name
    ,HairColor
    ,SkinHue
    ,EyeColor
    ,Gender
    ,Homeworld
    ,Species
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Characters;

--Load characters
INSERT INTO Dim_Characters
(
     DimCharacterID
	,CharactersID
    ,Name
    ,HairColor
    ,SkinHue
    ,EyeColor
    ,Gender
    ,Homeworld
    ,Species
)
	SELECT 
	  CharacterID AS DimCharacterID
     ,CharacterID AS CharacterID
     ,Name
     ,HairColor
     ,SkinColor
     ,EyeColor
     ,Gender
     ,HomeWorld
     ,Species
     
	FROM STAGE_STARWARSCHARACTERS

SELECT * FROM Dim_Characters;

-- CREATE PLANET TABLE
CREATE OR REPLACE TABLE Dim_Planets(
    DimPlanetID INT IDENTITY(1,1) CONSTRAINT PK_DimPlanetID PRIMARY KEY NOT NULL --Surrogate Key
	,PlanetID INTEGER NOT NULL --Natural Key
    ,PlanetName VARCHAR(255) NOT NULL
    ,Climate VARCHAR(255) NOT NULL
    ,Gravity VARCHAR(255) NOT NULL
    ,Terrain VARCHAR(255) NOT NULL
);

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Planets

--Load unknown members
INSERT INTO Dim_Planets
(
     DimPlanetID
	,PlanetID
    ,PlanetName
    ,Climate
    ,Gravity
    ,Terrain
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Planets;

--Load planets
INSERT INTO Dim_Planets
(
     DimPlanetID
	,PlanetID
    ,PlanetName
    ,Climate
    ,Gravity
    ,Terrain
)
	SELECT 
	  PlanetID AS DimPlanetID
     ,PlanetID AS PlanetID
    ,Name AS PlanetName
    ,Climate
    ,Gravity
    ,Terrain
     
	FROM STAGE_STARWARSPLANETS

SELECT * FROM Dim_Planets;

--CREATE TABLE DIM_SPECIES
CREATE OR REPLACE TABLE Dim_Species(
    DimSpeciesID INT IDENTITY(1,1) CONSTRAINT PK_DimSpeciesID PRIMARY KEY NOT NULL --Surrogate Key
	,SpeciesID INTEGER NOT NULL --Natural Key
    ,Species VARCHAR(255) NOT NULL
    ,Classification VARCHAR(255) NOT NULL
    ,Designation VARCHAR(255) NOT NULL
    ,SkinHues VARCHAR(255) NOT NULL
    ,HairColors VARCHAR(50) NOT NULL
    ,EyeColors VARCHAR(255) NOT NULL
    ,Language VARCHAR(255) NOT NULL
);
alter table Dim_Characters rename column charactersid to CharacterID
--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
DROP TABLE Dim_Species

--Load unknown members
INSERT INTO Dim_Species
(
     DimSpeciesID
	,SpeciesID
    ,Species
    ,Classification
    ,Designation
    ,SkinHues
    ,HairColors
    ,EyeColors
    ,Language
)
VALUES
( 
     -1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Species;
--Load species
INSERT INTO Dim_Species
(
     DimSpeciesID
	,SpeciesIDs
    ,Species
    ,Classification
    ,Designation
    ,SkinHues
    ,HairColors
    ,EyeColors
    ,Language
)
	SELECT 
	  SpeciesID AS DimSpeciesID
     ,SpeciesID AS SpeciesID
    ,Name AS Species
    ,Classification
    ,Designation
    ,SkinColors AS SkinHues
    ,HairColors
    ,EyeColors
    ,Language
     
	FROM STAGE_STARWARSSPECIES

SELECT * FROM Dim_Species