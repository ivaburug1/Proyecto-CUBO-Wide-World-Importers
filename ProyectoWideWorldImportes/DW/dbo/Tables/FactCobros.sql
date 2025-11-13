CREATE TABLE [dbo].[FactCobros] (
    [FactCobroID]        INT             IDENTITY (1, 1) NOT NULL,
    [DateID]             INT             NOT NULL,
    [PersonID]           INT             NOT NULL,
    [PaymentMethodID]    INT             NOT NULL,
    [InvoiceID]          INT             NULL,
    [TransactionAmount]  DECIMAL (18, 2) NULL,
    [TaxAmount]          DECIMAL (18, 2) NULL,
    [OutstandingBalance] DECIMAL (18, 2) NULL,
    [TotalAmount]        AS              ([TransactionAmount]+isnull([TaxAmount],(0))),
    PRIMARY KEY CLUSTERED ([FactCobroID] ASC),
    CONSTRAINT [FK_FactCobros_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]),
    CONSTRAINT [FK_FactCobros_DimPeopleCustomer] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[DimPeopleCustomer] ([PersonID]),
    CONSTRAINT [FK_FactCobros_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID])
);

