CREATE TABLE [dbo].[DimPayment] (
    [PaymentMethodID]   INT           NOT NULL,
    [PaymentMethodName] NVARCHAR (50) NULL,
    [LastEditedBy]      INT           NULL,
    [ValidFrom]         DATETIME2 (7) NULL,
    [ValidTo]           DATETIME2 (7) NULL,
    CONSTRAINT [PK_DimPayment] PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC)
);

