CREATE TABLE [dbo].[DimPeopleEmployee] (
    [PersonID]                INT            NOT NULL,
    [FullName]                NVARCHAR (50)  NULL,
    [IsPermittedToLogon]      BIT            NULL,
    [IsExternalLogonProvider] BIT            NULL,
    [IsSystemUser]            BIT            NULL,
    [IsSalesperson]           BIT            NULL,
    [UserPreferences]         NVARCHAR (MAX) NULL,
    [PhoneNumber]             NVARCHAR (20)  NULL,
    [FaxNumber]               NVARCHAR (20)  NULL,
    [EmailAddress]            NVARCHAR (256) NULL,
    CONSTRAINT [PK_DimPeopleEmployee] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);

