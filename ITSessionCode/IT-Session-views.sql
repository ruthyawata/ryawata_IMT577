/*****************************************
Course: IMT 577
Instructor: Sean Pettersen
IT Session: 8
Date: 11/14/2021
Notes: Create simple view
       Create aggregate view

Steps:
    1. Create simple view
    2. Create aggregate view
*****************************************/

--create a simple view
/**
Who are all of the characters in the Star Wars universe?
What are all of the planets in the Star Wars universe?
What are all of the species in the Star Wars universe?
What planet are the different characters from?
**/

CREATE VIEW all_starwars
    AS
SELECT DISTINCT  
		   Dim_Characters.Name AS Characters
          ,Dim_Planets.PlanetName AS Planets
          ,Dim_Species.Species AS Species
	FROM Dim_Planets
	LEFT OUTER JOIN Dim_Characters ON
	Dim_Characters.Homeworld = Dim_Planets.PlanetName 
    LEFT OUTER JOIN Dim_Species ON
	Dim_Species.Species = Dim_Characters.Species
    WHERE Characters != "Unknown"

SELECT * FROM Dim_Characters WHERE Name = "Unknown"
--create an simple view
/**
What are the tallest species? Show from tallest to shortest.

SELECT DISTINCT
    Dim_Species.Species
    ,Fact_Species.AvgHeight
    FROM Dim_Species
    INNER JOIN Fact_Species ON
    Fact_Species.DimSpeciesID = Dim_Species.DimSpeciesID
    ORDER BY Fact_Species.AvgHeight DESC
**/

--create an aggregate view
/**
What are the tallest species? Show from tallest to shortest.
**/
CREATE VIEW species_height
    AS
SELECT DISTINCT
    Dim_Species.Species
    ,ROUND(AVG(Fact_Characters.Height), 2) as Average
    FROM Dim_Species
    INNER JOIN Fact_Species ON
    Fact_Species.DimSpeciesID = Dim_Species.DimSpeciesID
    INNER JOIN Fact_Characters ON
    Fact_Characters.DimCharacterID = Fact_Species.DimCharacterID
    GROUP BY Dim_Species.Species
    ORDER BY Average DESC

--create an simple view
/**
What are the heaviest characters and what planets are they from? Show from lightest to heaviest.
**/
CREATE VIEW Heavist_Characters
    AS
SELECT DISTINCT
    Dim_Characters.Name
    ,Fact_Characters.Mass
    ,Dim_Planets.PlanetName
    FROM Dim_Characters
    INNER JOIN Fact_Characters ON
    Fact_Characters.DimCharacterID = Dim_Characters.DimCharacterID
    INNER JOIN Fact_Planets ON
    Fact_Planets.DimCharacterID = Dim_Characters.DimCharacterID
    INNER JOIN Dim_Planets ON
    Dim_Planets.DimPlanetID = Fact_Planets.DimPlanetID
    ORDER BY Fact_Characters.Mass ASC