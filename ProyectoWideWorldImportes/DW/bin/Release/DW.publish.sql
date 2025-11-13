/*
Script de implementación para DW

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW"
:setvar DefaultFilePrefix "DW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[DimGeo]...';


GO
CREATE TABLE [dbo].[DimGeo] (
    [CountryID]          INT               NOT NULL,
    [CountryName]        NVARCHAR (60)     NULL,
    [FormalName]         NVARCHAR (60)     NULL,
    [CountryType]        NVARCHAR (20)     NULL,
    [Continent]          NVARCHAR (30)     NULL,
    [Region]             NVARCHAR (30)     NULL,
    [Subregion]          NVARCHAR (30)     NULL,
    [StateProvinceID]    INT               NOT NULL,
    [StateProvinceCode]  NVARCHAR (5)      NULL,
    [StateProvinceName]  NVARCHAR (50)     NULL,
    [CountryID_FK]       INT               NULL,
    [SalesTerritory]     NVARCHAR (50)     NULL,
    [Border_State]       [sys].[geography] NULL,
    [CityID]             INT               NOT NULL,
    [CityName]           NVARCHAR (50)     NULL,
    [StateProvinceID_FK] INT               NULL,
    [Location_City]      [sys].[geography] NULL,
    CONSTRAINT [PK_DimGeo_1] PRIMARY KEY CLUSTERED ([CityID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimPayment]...';


GO
CREATE TABLE [dbo].[DimPayment] (
    [PaymentMethodID]   INT           NOT NULL,
    [PaymentMethodName] NVARCHAR (50) NULL,
    [LastEditedBy]      INT           NULL,
    [ValidFrom]         DATETIME2 (7) NULL,
    [ValidTo]           DATETIME2 (7) NULL,
    CONSTRAINT [PK_DimPayment] PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimPeopleCustomer]...';


GO
CREATE TABLE [dbo].[DimPeopleCustomer] (
    [PersonID]      INT            NOT NULL,
    [FullName]      NVARCHAR (50)  NULL,
    [PhoneNumber]   NVARCHAR (20)  NULL,
    [FaxNumber]     NVARCHAR (20)  NULL,
    [EmailAddress]  NVARCHAR (256) NULL,
    [IsSalesperson] BIT            NULL,
    CONSTRAINT [PK_DimPeopleCustomer] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimPeopleEmployee]...';


GO
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


GO
PRINT N'Creando Tabla [dbo].[DimProduct]...';


GO
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


GO
PRINT N'Creando Tabla [dbo].[DimSupplier]...';


GO
CREATE TABLE [dbo].[DimSupplier] (
    [SupplierCategoryID]       INT               NULL,
    [SupplierCategoryName]     NVARCHAR (50)     NULL,
    [SupplierID]               INT               NOT NULL,
    [SupplierName]             NVARCHAR (100)    NULL,
    [SupplierCategoryID_FK]    INT               NULL,
    [PrimaryContactPersonID]   INT               NULL,
    [AlternateContactPersonID] INT               NULL,
    [DeliveryMethodID]         INT               NULL,
    [DeliveryCityID]           INT               NULL,
    [PostalCityID]             INT               NULL,
    [SupplierReference]        NVARCHAR (20)     NULL,
    [BankAccountName]          NVARCHAR (50)     NULL,
    [BankAccountBranch]        NVARCHAR (50)     NULL,
    [BankAccountNumber]        NVARCHAR (20)     NULL,
    [BankInternationalCode]    NVARCHAR (20)     NULL,
    [PaymentDays]              INT               NULL,
    [DeliveryAddressLine1]     NVARCHAR (60)     NULL,
    [DeliveryAddressLine2]     NVARCHAR (60)     NULL,
    [DeliveryPostalCode]       NVARCHAR (10)     NULL,
    [DeliveryLocation]         [sys].[geography] NULL,
    [PostalAddressLine1]       NVARCHAR (60)     NULL,
    [PostalAddressLine2]       NVARCHAR (60)     NULL,
    [PostalPostalCode]         NVARCHAR (10)     NULL,
    CONSTRAINT [PK_DimSupplier] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimTiempo]...';


GO
CREATE TABLE [dbo].[DimTiempo] (
    [DateID]    INT           NOT NULL,
    [Date]      DATE          NOT NULL,
    [Year]      INT           NULL,
    [Quarter]   INT           NULL,
    [Month]     INT           NULL,
    [MonthName] NVARCHAR (20) NULL,
    [Day]       INT           NULL,
    [DayOfWeek] INT           NULL,
    [DayName]   NVARCHAR (20) NULL,
    CONSTRAINT [PK_DimTiempo] PRIMARY KEY CLUSTERED ([DateID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactCobros]...';


GO
CREATE TABLE [dbo].[FactCobros] (
    [FactCobroID]        INT             IDENTITY (1, 1) NOT NULL,
    [DateID]             INT             NOT NULL,
    [PersonID]           INT             NOT NULL,
    [PaymentMethodID]    INT             NOT NULL,
    [InvoiceID]          INT             NULL,
    [TransactionAmount]  DECIMAL (18, 2) NULL,
    [TaxAmount]          DECIMAL (18, 2) NULL,
    [OutstandingBalance] DECIMAL (18, 2) NULL,
    [TotalAmount]        AS              ([TransactionAmount] + isnull([TaxAmount], (0))),
    PRIMARY KEY CLUSTERED ([FactCobroID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactCompra]...';


GO
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
    CONSTRAINT [PK__FactComp__64D53F1A6665CDB2] PRIMARY KEY CLUSTERED ([FactCompraID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactVenta]...';


GO
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
    CONSTRAINT [PK__FactVent__68930A77C1986286] PRIMARY KEY CLUSTERED ([FactVentaID] ASC)
);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCobros_DimPayment]...';


GO
ALTER TABLE [dbo].[FactCobros]
    ADD CONSTRAINT [FK_FactCobros_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCobros_DimPeopleCustomer]...';


GO
ALTER TABLE [dbo].[FactCobros]
    ADD CONSTRAINT [FK_FactCobros_DimPeopleCustomer] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[DimPeopleCustomer] ([PersonID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCobros_DimTiempo]...';


GO
ALTER TABLE [dbo].[FactCobros]
    ADD CONSTRAINT [FK_FactCobros_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCompra_DimGeo]...';


GO
ALTER TABLE [dbo].[FactCompra]
    ADD CONSTRAINT [FK_FactCompra_DimGeo] FOREIGN KEY ([CityID]) REFERENCES [dbo].[DimGeo] ([CityID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCompra_DimPayment]...';


GO
ALTER TABLE [dbo].[FactCompra]
    ADD CONSTRAINT [FK_FactCompra_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCompra_DimProduct]...';


GO
ALTER TABLE [dbo].[FactCompra]
    ADD CONSTRAINT [FK_FactCompra_DimProduct] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[DimProduct] ([ProductID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCompra_DimSupplier]...';


GO
ALTER TABLE [dbo].[FactCompra]
    ADD CONSTRAINT [FK_FactCompra_DimSupplier] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[DimSupplier] ([SupplierID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactCompra_DimTiempo]...';


GO
ALTER TABLE [dbo].[FactCompra]
    ADD CONSTRAINT [FK_FactCompra_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimCustomer]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimCustomer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[DimPeopleCustomer] ([PersonID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimGeo]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimGeo] FOREIGN KEY ([CityID]) REFERENCES [dbo].[DimGeo] ([CityID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimPayment]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimPayment] FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[DimPayment] ([PaymentMethodID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimProduct]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimProduct] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[DimProduct] ([ProductID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimSalesperson]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimSalesperson] FOREIGN KEY ([SalespersonID]) REFERENCES [dbo].[DimPeopleEmployee] ([PersonID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactVenta_DimTiempo]...';


GO
ALTER TABLE [dbo].[FactVenta]
    ADD CONSTRAINT [FK_FactVenta_DimTiempo] FOREIGN KEY ([DateID]) REFERENCES [dbo].[DimTiempo] ([DateID]);


GO
PRINT N'Creando Procedimiento [dbo].[upLimpiezaDW]...';


GO




/*
	Fecha: 11/11/2025
	Desarrollador: Urso Ivan
	Descripción: Limpia todas las tablas del DW y desactiva temporalmente las FK.
*/
CREATE PROCEDURE [dbo].[upLimpiezaDW]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
		ALTER TABLE [dbo].[FactCobros] NOCHECK CONSTRAINT ALL;
        ALTER TABLE [dbo].[FactCompra] NOCHECK CONSTRAINT ALL;
        ALTER TABLE [dbo].[FactVenta] NOCHECK CONSTRAINT ALL;

        DELETE FROM [dbo].[FactCobros];
        DELETE FROM [dbo].[FactCompra];
        DELETE FROM [dbo].[FactVenta];

        DELETE FROM [dbo].[DimGeo]
        DELETE FROM [dbo].[DimPayment]
        DELETE FROM [dbo].[DimPeopleCustomer]
        DELETE FROM [dbo].[DimPeopleEmployee]
        DELETE FROM [dbo].[DimProduct]
        DELETE FROM [dbo].[DimSupplier]
		
        ALTER TABLE [dbo].[FactCobros] WITH CHECK CHECK CONSTRAINT ALL;
        ALTER TABLE [dbo].[FactCompra] WITH CHECK CHECK CONSTRAINT ALL;
        ALTER TABLE [dbo].[FactVenta] WITH CHECK CHECK CONSTRAINT ALL;

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMensaje NVARCHAR(126);
		DECLARE @ErrorSeveridad INT;
		DECLARE @ErrorEstado INT;

		SET @ErrorMensaje = ERROR_MESSAGE();
		SET @ErrorSeveridad = ERROR_SEVERITY();
		SET @ErrorEstado = ISNULL(NULLIF(ERROR_STATE(),0),1);

		EXEC [WideWorldImportersGrupoST].Errores.upErrores_Ins;

		RAISERROR (@ErrorMensaje, @ErrorSeveridad, @ErrorEstado);
	END CATCH;
END;
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
