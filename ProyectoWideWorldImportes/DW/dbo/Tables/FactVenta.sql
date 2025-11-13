CREATE TABLE [dbo].[FactVenta] (
    [FactVentaID]      INT             IDENTITY (1, 1) NOT NULL,
    [DateID]           INT             NULL,
    [ProductID]        INT             NULL,
    [CityID]           INT             NULL,
    [CustomerID]       INT             NULL,
    [SalespersonID]    INT             NULL,
    [PaymentMethodID]  INT             NULL,
    [DeliveryMethodID] INT             NULL,
    [Quantity]         INT             NULL,
    [UnitPrice]        DECIMAL (18, 2) NULL,
    [TaxAmount]        DECIMAL (18, 2) NULL,
    [LineProfit]       DECIMAL (18, 2) NULL,
    [ExtendedPrice]    DECIMAL (18, 2) NULL,
    [InvoiceID]        INT             NULL,
    CONSTRAINT [PK__FactVent__68930A77C1986286] PRIMARY KEY CLUSTERED ([FactVentaID] ASC),
    CONSTRAINT [FK_FactVenta_DimCustomer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[DimPeopleCustomer] ([PersonID]),
    CONSTRAINT [FK_FactVenta_DimGeo] FOREIGN KEY ([CityID]) REFERENCES [dbo].[DimGeo] ([CityID]),
    CONSTRAINT [FK_FactVenta_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]),
    CONSTRAINT [FK_FactVenta_DimProduct] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[DimProduct] ([ProductID]),
    CONSTRAINT [FK_FactVenta_DimSalesperson] FOREIGN KEY ([SalespersonID]) REFERENCES [dbo].[DimPeopleEmployee] ([PersonID]),
    CONSTRAINT [FK_FactVenta_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID])
);

