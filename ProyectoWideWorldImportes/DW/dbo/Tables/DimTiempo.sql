CREATE TABLE [dbo].[DimTiempo] (
    [DateID]    INT           NOT NULL,
    [Date]      DATE          NOT NULL,
    [Year]      INT           NULL,
    [Quarter]   INT           NULL,
    [Month]     INT           NULL,
    [MonthName] NVARCHAR (20) NULL,
    [Day]       INT           NULL,
    [DayOfWeek] INT           NULL,
    [DayName]   NVARCHAR (20) NULL,
    CONSTRAINT [PK_DimTiempo] PRIMARY KEY CLUSTERED ([DateID] ASC)
);

