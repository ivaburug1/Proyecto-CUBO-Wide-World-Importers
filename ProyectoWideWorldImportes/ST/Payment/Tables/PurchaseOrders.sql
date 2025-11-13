CREATE TABLE [Payment].[PurchaseOrders] (
    [PurchaseOrderID]      INT            NOT NULL,
    [SupplierID]           INT            NOT NULL,
    [OrderDate]            DATE           NOT NULL,
    [DeliveryMethodID]     INT            NOT NULL,
    [ContactPersonID]      INT            NOT NULL,
    [ExpectedDeliveryDate] DATE           NULL,
    [SupplierReference]    NVARCHAR (20)  NULL,
    [IsOrderFinalized]     BIT            NOT NULL,
    [Comments]             NVARCHAR (MAX) NULL,
    [InternalComments]     NVARCHAR (MAX) NULL,
    [LastEditedBy]         INT            NOT NULL,
    [LastEditedWhen]       DATETIME2 (7)  NOT NULL,
    PRIMARY KEY CLUSTERED ([PurchaseOrderID] ASC)
);

