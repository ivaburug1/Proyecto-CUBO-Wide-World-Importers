CREATE TABLE [Product].[StockItemHoldings] (
    [StockItemID]           INT             NOT NULL,
    [QuantityOnHand]        INT             NOT NULL,
    [BinLocation]           NVARCHAR (20)   NOT NULL,
    [LastStocktakeQuantity] INT             NOT NULL,
    [LastCostPrice]         DECIMAL (18, 2) NOT NULL,
    [ReorderLevel]          INT             NOT NULL,
    [TargetStockLevel]      INT             NOT NULL,
    [LastEditedBy]          INT             NOT NULL,
    [LastEditedWhen]        DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([StockItemID] ASC)
);

