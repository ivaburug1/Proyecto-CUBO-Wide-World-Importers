CREATE TABLE [Customer].[CustomerCategories] (
    [CustomerCategoryID]   INT           NOT NULL,
    [CustomerCategoryName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]         INT           NOT NULL,
    [ValidFrom]            DATETIME2 (7) NOT NULL,
    [ValidTo]              DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([CustomerCategoryID] ASC)
);

