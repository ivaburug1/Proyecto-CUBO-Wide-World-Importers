CREATE TABLE [dbo].[DimPeopleCustomer] (
    [PersonID]      INT            NOT NULL,
    [FullName]      NVARCHAR (50)  NULL,
    [PhoneNumber]   NVARCHAR (20)  NULL,
    [FaxNumber]     NVARCHAR (20)  NULL,
    [EmailAddress]  NVARCHAR (256) NULL,
    [IsSalesperson] BIT            NULL,
    CONSTRAINT [PK_DimPeopleCustomer] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);

