CREATE OR REPLACE SECURE VIEW ViewDim_Channel
    AS
    SELECT
        DimChannelID
        ,SourceChannelID
        ,SourceChannelCategoryID
        ,ChannelName
        ,ChannelCategory
    FROM Dim_Channel