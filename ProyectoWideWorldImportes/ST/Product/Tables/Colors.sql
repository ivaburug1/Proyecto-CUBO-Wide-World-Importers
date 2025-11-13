CREATE TABLE [Product].[Colors] (
    [ColorID]      INT           NOT NULL,
    [ColorName]    NVARCHAR (20) NOT NULL,
    [LastEditedBy] INT           NOT NULL,
    [ValidFrom]    DATETIME2 (7) NOT NULL,
    [ValidTo]      DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([ColorID] ASC)
);

