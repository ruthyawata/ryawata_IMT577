--CREATE TABLE DIM_CHANNEL
CREATE OR REPLACE TABLE Dim_Channel(
    DimChannelID INTEGER IDENTITY(1,1) CONSTRAINT PK_DimChannelID PRIMARY KEY NOT NULL --Surrogate Key
    ,ChannelID INTEGER NOT NULL
    ,ChannelCategoryID INTEGER NOT NULL
    ,ChannelName VARCHAR(255) NOT NULL
    ,ChannelCategory VARCHAR(255) NOT NULL
);

SELECT * FROM Dim_Channel;

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.
--DROP TABLE Dim_Channel;

--Load unknown members
INSERT INTO Dim_Channel
(
    DimChannelID
    ,ChannelID
    ,ChannelCategoryID
    ,ChannelName
    ,ChannelCategory
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,'Unknown' 
    ,'Unknown'
);

SELECT * FROM Dim_Channel;

--Load rows from Stage_Channel
INSERT INTO Dim_Channel
(
    DimChannelID
    ,ChannelID
    ,ChannelCategoryID
    ,ChannelName
    ,ChannelCategory
)
SELECT 
    Stage_Channel.ChannelID AS ChannelID
    ,Stage_ChannelCategory.ChannelCategoryID AS ChannelCategoryID
    ,Stage_Channel.FirstName AS FirstName
    ,Stage_Channel.LastName AS LastName
    ,Stage_Channel.Gender AS CustomerGender
FROM Stage_Channel
INNER JOIN Stage_ChannelCategory ON
Stage_ChannelCategory = Stage_Channel.Address;

SELECT * FROM Dim_Channel;