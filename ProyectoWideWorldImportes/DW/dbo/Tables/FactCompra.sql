CREATE TABLE [dbo].[FactCompra] (
    [FactCompraID]    INT             IDENTITY (1, 1) NOT NULL,
    [DateID]          INT             NOT NULL,
    [ProductID]       INT             NOT NULL,
    [SupplierID]      INT             NOT NULL,
    [CityID]          INT             NOT NULL,
    [PaymentMethodID] INT             NOT NULL,
    [Quantity]        INT             NULL,
    [UnitPrice]       DECIMAL (18, 2) NULL,
    [Total]           DECIMAL (18, 2) NULL,
    CONSTRAINT [PK__FactComp__64D53F1A6665CDB2] PRIMARY KEY CLUSTERED ([FactCompraID] ASC),
    CONSTRAINT [FK_FactCompra_DimGeo] FOREIGN KEY ([CityID]) REFERENCES [dbo].[DimGeo] ([CityID]),
    CONSTRAINT [FK_FactCompra_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]),
    CONSTRAINT [FK_FactCompra_DimProduct] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[DimProduct] ([ProductID]),
    CONSTRAINT [FK_FactCompra_DimSupplier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[DimSupplier] ([SupplierID]),
    CONSTRAINT [FK_FactCompra_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID])
);

