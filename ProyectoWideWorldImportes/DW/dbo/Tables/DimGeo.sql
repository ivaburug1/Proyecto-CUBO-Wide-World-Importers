CREATE TABLE [dbo].[DimGeo] (
    [CountryID]          INT               NOT NULL,
    [CountryName]        NVARCHAR (60)     NULL,
    [FormalName]         NVARCHAR (60)     NULL,
    [CountryType]        NVARCHAR (20)     NULL,
    [Continent]          NVARCHAR (30)     NULL,
    [Region]             NVARCHAR (30)     NULL,
    [Subregion]          NVARCHAR (30)     NULL,
    [StateProvinceID]    INT               NOT NULL,
    [StateProvinceCode]  NVARCHAR (5)      NULL,
    [StateProvinceName]  NVARCHAR (50)     NULL,
    [CountryID_FK]       INT               NULL,
    [SalesTerritory]     NVARCHAR (50)     NULL,
    [Border_State]       [sys].[geography] NULL,
    [CityID]             INT               NOT NULL,
    [CityName]           NVARCHAR (50)     NULL,
    [StateProvinceID_FK] INT               NULL,
    [Location_City]      [sys].[geography] NULL,
    CONSTRAINT [PK_DimGeo_1] PRIMARY KEY CLUSTERED ([CityID] ASC)
);

