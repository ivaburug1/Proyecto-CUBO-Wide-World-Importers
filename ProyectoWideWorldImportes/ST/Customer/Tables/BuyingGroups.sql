CREATE TABLE [Customer].[BuyingGroups] (
    [BuyingGroupID]   INT           NOT NULL,
    [BuyingGroupName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]    INT           NOT NULL,
    [ValidFrom]       DATETIME2 (7) NOT NULL,
    [ValidTo]         DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([BuyingGroupID] ASC)
);

