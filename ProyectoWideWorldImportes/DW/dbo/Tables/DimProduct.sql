CREATE TABLE [dbo].[DimProduct] (
    [ProductID]              INT             NOT NULL,
    [StockItemName]          NVARCHAR (100)  NULL,
    [SupplierID]             INT             NULL,
    [ColorID]                INT             NULL,
    [UnitPackageID]          INT             NULL,
    [OuterPackageID]         INT             NULL,
    [Brand]                  NVARCHAR (50)   NULL,
    [Size]                   NVARCHAR (20)   NULL,
    [LeadTimeDays]           INT             NULL,
    [QuantityPerOuter]       INT             NULL,
    [IsChillerStock]         BIT             NULL,
    [TaxRate]                DECIMAL (18, 2) NULL,
    [UnitPrice]              DECIMAL (18, 2) NULL,
    [RecommendedRetailPrice] DECIMAL (18, 2) NULL,
    [TypicalWeightPerUnit]   DECIMAL (18, 2) NULL,
    [SearchDetails]          NVARCHAR (MAX)  NULL,
    [ColorName]              NVARCHAR (20)   NULL,
    [UnitPackageTypeName]    NVARCHAR (50)   NULL,
    [OuterPackageTypeName]   NVARCHAR (50)   NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);

