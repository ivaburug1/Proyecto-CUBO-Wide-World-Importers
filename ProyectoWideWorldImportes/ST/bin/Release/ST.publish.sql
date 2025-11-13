/*
Script de implementación para ST

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ST"
:setvar DefaultFilePrefix "ST"
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
PRINT N'Creando Esquema [Customer]...';


GO
CREATE SCHEMA [Customer]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Errores]...';


GO
CREATE SCHEMA [Errores]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [General]...';


GO
CREATE SCHEMA [General]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Geo]...';


GO
CREATE SCHEMA [Geo]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Payment]...';


GO
CREATE SCHEMA [Payment]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Product]...';


GO
CREATE SCHEMA [Product]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Sales]...';


GO
CREATE SCHEMA [Sales]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Esquema [Supplier]...';


GO
CREATE SCHEMA [Supplier]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Tabla [Customer].[Customers]...';


GO
CREATE TABLE [Customer].[Customers] (
    [CustomerID]                 INT               NOT NULL,
    [CustomerName]               NVARCHAR (100)    NOT NULL,
    [BillToCustomerID]           INT               NOT NULL,
    [CustomerCategoryID]         INT               NOT NULL,
    [BuyingGroupID]              INT               NULL,
    [PrimaryContactPersonID]     INT               NOT NULL,
    [AlternateContactPersonID]   INT               NULL,
    [DeliveryMethodID]           INT               NOT NULL,
    [DeliveryCityID]             INT               NOT NULL,
    [PostalCityID]               INT               NOT NULL,
    [CreditLimit]                DECIMAL (18, 2)   NULL,
    [AccountOpenedDate]          DATE              NOT NULL,
    [StandardDiscountPercentage] DECIMAL (18, 3)   NOT NULL,
    [IsStatementSent]            BIT               NOT NULL,
    [IsOnCreditHold]             BIT               NOT NULL,
    [PaymentDays]                INT               NOT NULL,
    [PhoneNumber]                NVARCHAR (20)     NOT NULL,
    [FaxNumber]                  NVARCHAR (20)     NOT NULL,
    [DeliveryRun]                NVARCHAR (5)      NULL,
    [RunPosition]                NVARCHAR (5)      NULL,
    [WebsiteURL]                 NVARCHAR (256)    NOT NULL,
    [DeliveryAddressLine1]       NVARCHAR (60)     NOT NULL,
    [DeliveryAddressLine2]       NVARCHAR (60)     NULL,
    [DeliveryPostalCode]         NVARCHAR (10)     NOT NULL,
    [DeliveryLocation]           [sys].[geography] NULL,
    [PostalAddressLine1]         NVARCHAR (60)     NOT NULL,
    [PostalAddressLine2]         NVARCHAR (60)     NULL,
    [PostalPostalCode]           NVARCHAR (10)     NOT NULL,
    [LastEditedBy]               INT               NOT NULL,
    [ValidFrom]                  DATETIME2 (7)     NOT NULL,
    [ValidTo]                    DATETIME2 (7)     NOT NULL,
    PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);


GO
PRINT N'Creando Tabla [Customer].[CustomerCategories]...';


GO
CREATE TABLE [Customer].[CustomerCategories] (
    [CustomerCategoryID]   INT           NOT NULL,
    [CustomerCategoryName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]         INT           NOT NULL,
    [ValidFrom]            DATETIME2 (7) NOT NULL,
    [ValidTo]              DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([CustomerCategoryID] ASC)
);


GO
PRINT N'Creando Tabla [Customer].[BuyingGroups]...';


GO
CREATE TABLE [Customer].[BuyingGroups] (
    [BuyingGroupID]   INT           NOT NULL,
    [BuyingGroupName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]    INT           NOT NULL,
    [ValidFrom]       DATETIME2 (7) NOT NULL,
    [ValidTo]         DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([BuyingGroupID] ASC)
);


GO
PRINT N'Creando Tabla [Customer].[People]...';


GO
CREATE TABLE [Customer].[People] (
    [PersonID]                INT             NOT NULL,
    [FullName]                NVARCHAR (50)   NOT NULL,
    [PreferredName]           NVARCHAR (50)   NOT NULL,
    [SearchName]              NVARCHAR (50)   NOT NULL,
    [IsPermittedToLogon]      BIT             NOT NULL,
    [LogonName]               NVARCHAR (50)   NULL,
    [IsExternalLogonProvider] BIT             NOT NULL,
    [HashedPassword]          VARBINARY (MAX) NULL,
    [IsSystemUser]            BIT             NOT NULL,
    [IsEmployee]              BIT             NOT NULL,
    [IsSalesperson]           BIT             NOT NULL,
    [UserPreferences]         NVARCHAR (MAX)  NULL,
    [PhoneNumber]             NVARCHAR (20)   NULL,
    [FaxNumber]               NVARCHAR (20)   NULL,
    [EmailAddress]            NVARCHAR (256)  NULL,
    [Photo]                   VARBINARY (MAX) NULL,
    [CustomFields]            NVARCHAR (MAX)  NULL,
    [OtherLanguages]          NVARCHAR (MAX)  NULL,
    [LastEditedBy]            INT             NOT NULL,
    [ValidFrom]               DATETIME2 (7)   NOT NULL,
    [ValidTo]                 DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([PersonID] ASC)
);


GO
PRINT N'Creando Tabla [Errores].[Errores]...';


GO
CREATE TABLE [Errores].[Errores] (
    [ErrorID]       INT             IDENTITY (1, 1) NOT NULL,
    [FechaError]    DATETIME        NOT NULL,
    [Usuario]       NVARCHAR (128)  NULL,
    [Aplicacion]    NVARCHAR (128)  NULL,
    [Numero]        INT             NULL,
    [Severidad]     INT             NULL,
    [Estado]        INT             NULL,
    [Procedimiento] NVARCHAR (128)  NULL,
    [Linea]         INT             NULL,
    [Mensaje]       NVARCHAR (4000) NULL,
    [Paquete]       NVARCHAR (128)  NULL,
    [NumPaquete]    NVARCHAR (128)  NULL,
    [NumContenedor] NVARCHAR (128)  NULL,
    [Tarea]         NVARCHAR (128)  NULL,
    [NumTarea]      NVARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([ErrorID] ASC)
);


GO
PRINT N'Creando Tabla [Geo].[DimCountries]...';


GO
CREATE TABLE [Geo].[DimCountries] (
    [CountryID]                INT               NOT NULL,
    [CountryName]              NVARCHAR (60)     NOT NULL,
    [FormalName]               NVARCHAR (60)     NOT NULL,
    [IsoAlpha3Code]            NVARCHAR (3)      NULL,
    [IsoNumericCode]           INT               NULL,
    [CountryType]              NVARCHAR (20)     NULL,
    [LatestRecordedPopulation] BIGINT            NULL,
    [Continent]                NVARCHAR (30)     NOT NULL,
    [Region]                   NVARCHAR (30)     NOT NULL,
    [Subregion]                NVARCHAR (30)     NOT NULL,
    [Border]                   [sys].[geography] NULL,
    [LastEditedBy]             INT               NOT NULL,
    [ValidFrom]                DATETIME2 (7)     NOT NULL,
    [ValidTo]                  DATETIME2 (7)     NOT NULL,
    PRIMARY KEY CLUSTERED ([CountryID] ASC)
);


GO
PRINT N'Creando Tabla [Geo].[DimCities]...';


GO
CREATE TABLE [Geo].[DimCities] (
    [CityID]                   INT               NOT NULL,
    [CityName]                 NVARCHAR (50)     NOT NULL,
    [StateProvinceID]          INT               NOT NULL,
    [Location]                 [sys].[geography] NULL,
    [LatestRecordedPopulation] BIGINT            NULL,
    [LastEditedBy]             INT               NOT NULL,
    [ValidFrom]                DATETIME2 (7)     NOT NULL,
    [ValidTo]                  DATETIME2 (7)     NOT NULL,
    PRIMARY KEY CLUSTERED ([CityID] ASC)
);


GO
PRINT N'Creando Tabla [Geo].[DimStateProvinces]...';


GO
CREATE TABLE [Geo].[DimStateProvinces] (
    [StateProvinceID]          INT               NOT NULL,
    [StateProvinceCode]        NVARCHAR (5)      NOT NULL,
    [StateProvinceName]        NVARCHAR (50)     NOT NULL,
    [CountryID]                INT               NOT NULL,
    [SalesTerritory]           NVARCHAR (50)     NOT NULL,
    [Border]                   [sys].[geography] NULL,
    [LatestRecordedPopulation] BIGINT            NULL,
    [LastEditedBy]             INT               NOT NULL,
    [ValidFrom]                DATETIME2 (7)     NOT NULL,
    [ValidTo]                  DATETIME2 (7)     NOT NULL,
    PRIMARY KEY CLUSTERED ([StateProvinceID] ASC)
);


GO
PRINT N'Creando Tabla [Payment].[CustomerTransactions]...';


GO
CREATE TABLE [Payment].[CustomerTransactions] (
    [CustomerTransactionID] INT             NOT NULL,
    [CustomerID]            INT             NOT NULL,
    [TransactionTypeID]     INT             NOT NULL,
    [InvoiceID]             INT             NULL,
    [PaymentMethodID]       INT             NULL,
    [TransactionDate]       DATE            NOT NULL,
    [AmountExcludingTax]    DECIMAL (18, 2) NOT NULL,
    [TaxAmount]             DECIMAL (18, 2) NOT NULL,
    [TransactionAmount]     DECIMAL (18, 2) NOT NULL,
    [OutstandingBalance]    DECIMAL (18, 2) NOT NULL,
    [FinalizationDate]      DATE            NULL,
    [IsFinalized]           BIT             NULL,
    [LastEditedBy]          INT             NOT NULL,
    [LastEditedWhen]        DATETIME2 (7)   NOT NULL,
    CONSTRAINT [PK_CustomerTransactions] PRIMARY KEY CLUSTERED ([CustomerTransactionID] ASC)
);


GO
PRINT N'Creando Tabla [Payment].[PurchaseOrderLines]...';


GO
CREATE TABLE [Payment].[PurchaseOrderLines] (
    [PurchaseOrderLineID]       INT             NOT NULL,
    [PurchaseOrderID]           INT             NOT NULL,
    [StockItemID]               INT             NOT NULL,
    [OrderedOuters]             INT             NOT NULL,
    [Description]               NVARCHAR (100)  NOT NULL,
    [ReceivedOuters]            INT             NOT NULL,
    [PackageTypeID]             INT             NOT NULL,
    [ExpectedUnitPricePerOuter] DECIMAL (18, 2) NULL,
    [LastReceiptDate]           DATE            NULL,
    [IsOrderLineFinalized]      BIT             NOT NULL,
    [LastEditedBy]              INT             NOT NULL,
    [LastEditedWhen]            DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([PurchaseOrderLineID] ASC)
);


GO
PRINT N'Creando Tabla [Payment].[PurchaseOrders]...';


GO
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


GO
PRINT N'Creando Tabla [Product].[DeliveryMethods]...';


GO
CREATE TABLE [Product].[DeliveryMethods] (
    [DeliveryMethodID]   INT           NOT NULL,
    [DeliveryMethodName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]       INT           NOT NULL,
    [ValidFrom]          DATETIME2 (7) NOT NULL,
    [ValidTo]            DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([DeliveryMethodID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[StockItemTransactions]...';


GO
CREATE TABLE [Product].[StockItemTransactions] (
    [StockItemTransactionID]  INT             NOT NULL,
    [StockItemID]             INT             NOT NULL,
    [TransactionTypeID]       INT             NOT NULL,
    [CustomerID]              INT             NULL,
    [InvoiceID]               INT             NULL,
    [SupplierID]              INT             NULL,
    [PurchaseOrderID]         INT             NULL,
    [TransactionOccurredWhen] DATETIME2 (7)   NOT NULL,
    [Quantity]                DECIMAL (18, 3) NOT NULL,
    [LastEditedBy]            INT             NOT NULL,
    [LastEditedWhen]          DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([StockItemTransactionID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[StockItemHoldings]...';


GO
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


GO
PRINT N'Creando Tabla [Product].[StockItems]...';


GO
CREATE TABLE [Product].[StockItems] (
    [StockItemID]            INT             NOT NULL,
    [StockItemName]          NVARCHAR (100)  NOT NULL,
    [SupplierID]             INT             NOT NULL,
    [ColorID]                INT             NULL,
    [UnitPackageID]          INT             NOT NULL,
    [OuterPackageID]         INT             NOT NULL,
    [Brand]                  NVARCHAR (50)   NULL,
    [Size]                   NVARCHAR (20)   NULL,
    [LeadTimeDays]           INT             NOT NULL,
    [QuantityPerOuter]       INT             NOT NULL,
    [IsChillerStock]         BIT             NOT NULL,
    [Barcode]                NVARCHAR (50)   NULL,
    [TaxRate]                DECIMAL (18, 3) NOT NULL,
    [UnitPrice]              DECIMAL (18, 2) NOT NULL,
    [RecommendedRetailPrice] DECIMAL (18, 2) NULL,
    [TypicalWeightPerUnit]   DECIMAL (18, 3) NOT NULL,
    [MarketingComments]      NVARCHAR (MAX)  NULL,
    [InternalComments]       NVARCHAR (MAX)  NULL,
    [Photo]                  VARBINARY (MAX) NULL,
    [CustomFields]           NVARCHAR (MAX)  NULL,
    [Tags]                   NVARCHAR (MAX)  NULL,
    [SearchDetails]          NVARCHAR (MAX)  NOT NULL,
    [LastEditedBy]           INT             NOT NULL,
    [ValidFrom]              DATETIME2 (7)   NOT NULL,
    [ValidTo]                DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([StockItemID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[PackageTypes]...';


GO
CREATE TABLE [Product].[PackageTypes] (
    [PackageTypeID]   INT           NOT NULL,
    [PackageTypeName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]    INT           NOT NULL,
    [ValidFrom]       DATETIME2 (7) NOT NULL,
    [ValidTo]         DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([PackageTypeID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[PaymentMethods]...';


GO
CREATE TABLE [Product].[PaymentMethods] (
    [PaymentMethodID]   INT           NOT NULL,
    [PaymentMethodName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]      INT           NOT NULL,
    [ValidFrom]         DATETIME2 (7) NOT NULL,
    [ValidTo]           DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[Colors]...';


GO
CREATE TABLE [Product].[Colors] (
    [ColorID]      INT           NOT NULL,
    [ColorName]    NVARCHAR (20) NOT NULL,
    [LastEditedBy] INT           NOT NULL,
    [ValidFrom]    DATETIME2 (7) NOT NULL,
    [ValidTo]      DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([ColorID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[OrderLines]...';


GO
CREATE TABLE [Product].[OrderLines] (
    [OrderLineID]          INT             NOT NULL,
    [OrderID]              INT             NOT NULL,
    [StockItemID]          INT             NOT NULL,
    [Description]          NVARCHAR (100)  NOT NULL,
    [PackageTypeID]        INT             NOT NULL,
    [Quantity]             INT             NOT NULL,
    [UnitPrice]            DECIMAL (18, 2) NOT NULL,
    [TaxRate]              DECIMAL (18, 3) NOT NULL,
    [PickedQuantity]       INT             NOT NULL,
    [PickingCompletedWhen] DATETIME2 (7)   NULL,
    [LastEditedBy]         INT             NOT NULL,
    [LastEditedWhen]       DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderLineID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[Invoices]...';


GO
CREATE TABLE [Product].[Invoices] (
    [InvoiceID]                   INT            NOT NULL,
    [CustomerID]                  INT            NOT NULL,
    [BillToCustomerID]            INT            NOT NULL,
    [OrderID]                     INT            NULL,
    [DeliveryMethodID]            INT            NOT NULL,
    [ContactPersonID]             INT            NOT NULL,
    [AccountsPersonID]            INT            NOT NULL,
    [SalespersonPersonID]         INT            NOT NULL,
    [PackedByPersonID]            INT            NOT NULL,
    [InvoiceDate]                 DATE           NOT NULL,
    [CustomerPurchaseOrderNumber] NVARCHAR (20)  NULL,
    [IsCreditNote]                BIT            NOT NULL,
    [CreditNoteReason]            NVARCHAR (MAX) NULL,
    [Comments]                    NVARCHAR (MAX) NULL,
    [DeliveryInstructions]        NVARCHAR (MAX) NULL,
    [InternalComments]            NVARCHAR (MAX) NULL,
    [TotalDryItems]               INT            NOT NULL,
    [TotalChillerItems]           INT            NOT NULL,
    [DeliveryRun]                 NVARCHAR (5)   NULL,
    [RunPosition]                 NVARCHAR (5)   NULL,
    [ReturnedDeliveryData]        NVARCHAR (MAX) NULL,
    [ConfirmedDeliveryTime]       DATETIME2 (7)  NULL,
    [ConfirmedReceivedBy]         NVARCHAR (50)  NULL,
    [LastEditedBy]                INT            NOT NULL,
    [LastEditedWhen]              DATETIME2 (7)  NOT NULL,
    PRIMARY KEY CLUSTERED ([InvoiceID] ASC)
);


GO
PRINT N'Creando Tabla [Product].[InvoiceLines]...';


GO
CREATE TABLE [Product].[InvoiceLines] (
    [InvoiceLineID]  INT             NOT NULL,
    [InvoiceID]      INT             NOT NULL,
    [StockItemID]    INT             NOT NULL,
    [Description]    NVARCHAR (100)  NOT NULL,
    [PackageTypeID]  INT             NOT NULL,
    [Quantity]       INT             NOT NULL,
    [UnitPrice]      DECIMAL (18, 2) NOT NULL,
    [TaxRate]        DECIMAL (18, 3) NOT NULL,
    [TaxAmount]      DECIMAL (18, 2) NOT NULL,
    [LineProfit]     DECIMAL (18, 2) NOT NULL,
    [ExtendedPrice]  DECIMAL (18, 2) NOT NULL,
    [LastEditedBy]   INT             NOT NULL,
    [LastEditedWhen] DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([InvoiceLineID] ASC)
);


GO
PRINT N'Creando Tabla [Supplier].[SupplierCategories]...';


GO
CREATE TABLE [Supplier].[SupplierCategories] (
    [SupplierCategoryID]   INT           NOT NULL,
    [SupplierCategoryName] NVARCHAR (50) NOT NULL,
    [LastEditedBy]         INT           NOT NULL,
    [ValidFrom]            DATETIME2 (7) NOT NULL,
    [ValidTo]              DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([SupplierCategoryID] ASC)
);


GO
PRINT N'Creando Tabla [Supplier].[SupplierTransactions]...';


GO
CREATE TABLE [Supplier].[SupplierTransactions] (
    [SupplierTransactionID] INT             NOT NULL,
    [SupplierID]            INT             NOT NULL,
    [TransactionTypeID]     INT             NOT NULL,
    [PurchaseOrderID]       INT             NULL,
    [PaymentMethodID]       INT             NULL,
    [SupplierInvoiceNumber] NVARCHAR (20)   NULL,
    [TransactionDate]       DATE            NOT NULL,
    [AmountExcludingTax]    DECIMAL (18, 2) NOT NULL,
    [TaxAmount]             DECIMAL (18, 2) NOT NULL,
    [TransactionAmount]     DECIMAL (18, 2) NOT NULL,
    [OutstandingBalance]    DECIMAL (18, 2) NOT NULL,
    [FinalizationDate]      DATE            NULL,
    [IsFinalized]           BIT             NULL,
    [LastEditedBy]          INT             NOT NULL,
    [LastEditedWhen]        DATETIME2 (7)   NOT NULL,
    PRIMARY KEY CLUSTERED ([SupplierTransactionID] ASC)
);


GO
PRINT N'Creando Tabla [Supplier].[Suppliers]...';


GO
CREATE TABLE [Supplier].[Suppliers] (
    [SupplierID]               INT               NOT NULL,
    [SupplierName]             NVARCHAR (100)    NOT NULL,
    [SupplierCategoryID]       INT               NOT NULL,
    [PrimaryContactPersonID]   INT               NOT NULL,
    [AlternateContactPersonID] INT               NULL,
    [DeliveryMethodID]         INT               NULL,
    [DeliveryCityID]           INT               NOT NULL,
    [PostalCityID]             INT               NOT NULL,
    [SupplierReference]        NVARCHAR (20)     NULL,
    [BankAccountName]          NVARCHAR (50)     NULL,
    [BankAccountBranch]        NVARCHAR (50)     NULL,
    [BankAccountCode]          NVARCHAR (20)     NULL,
    [BankAccountNumber]        NVARCHAR (20)     NULL,
    [BankInternationalCode]    NVARCHAR (20)     NULL,
    [PaymentDays]              INT               NOT NULL,
    [InternalComments]         NVARCHAR (MAX)    NULL,
    [PhoneNumber]              NVARCHAR (20)     NULL,
    [FaxNumber]                NVARCHAR (20)     NULL,
    [WebsiteURL]               NVARCHAR (256)    NULL,
    [DeliveryAddressLine1]     NVARCHAR (60)     NOT NULL,
    [DeliveryAddressLine2]     NVARCHAR (60)     NULL,
    [DeliveryPostalCode]       NVARCHAR (10)     NOT NULL,
    [DeliveryLocation]         [sys].[geography] NULL,
    [PostalAddressLine1]       NVARCHAR (60)     NOT NULL,
    [PostalAddressLine2]       NVARCHAR (60)     NULL,
    [PostalPostalCode]         NVARCHAR (10)     NOT NULL,
    [LastEditedBy]             INT               NOT NULL,
    [ValidFrom]                DATETIME2 (7)     NOT NULL,
    [ValidTo]                  DATETIME2 (7)     NOT NULL,
    PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);


GO
PRINT N'Creando Restricción DEFAULT [Errores].[DF_Errores_FechaError]...';


GO
ALTER TABLE [Errores].[Errores]
    ADD CONSTRAINT [DF_Errores_FechaError] DEFAULT (getdate()) FOR [FechaError];


GO
PRINT N'Creando Procedimiento [Errores].[upErrores_Ins]...';


GO



CREATE PROCEDURE [Errores].[upErrores_Ins] 
	@ErrorID INT = 0 OUTPUT
AS

/*
	Fecha: 24/10/2025
	Desarrollador: Ivan Urso
	Comentario: Inserte registros en la tabla Errores.Errores 
*/


BEGIN 

    SET nocount on

    BEGIN TRY

		BEGIN TRAN
		
			INSERT INTO Errores.Errores 
				(Numero, Severidad, Estado, Procedimiento, Linea, Mensaje) 
			VALUES 
				(ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
				
		COMMIT TRAN
		
	    SET @ErrorID = SCOPE_IDENTITY()
		
    END TRY

    BEGIN CATCH

		DECLARE @ErrorMensaje NVARCHAR(128)
		DECLARE @ErrorSeveridad INT
		DECLARE @ErrorEstado INT

		IF @@TRANcount > 0
			ROLLBACK TRAN
		
		SET @ErrorMensaje = ERROR_message()
		SET @ErrorSeveridad = ERROR_severity()
		SET @ErrorEstado = ERROR_state()

		RAISERROR(@ErrorMensaje,@ErrorSeveridad,@ErrorEstado)
        
    END CATCH

END
GO
PRINT N'Creando Procedimiento [General].[upInicializacion_Del]...';


GO






CREATE PROCEDURE [General].[upInicializacion_Del]
AS

BEGIN

/*
	Fecha: 07/10/2025
	Desarrollador: Ivan Urso
	Comentario: Inicializa todas las tablas del ST - sin Dim Tiempo
*/

	SET NOCOUNT ON

	BEGIN TRY
		
		-- [Customer].[BuyingGroups]
		ALTER TABLE [Customer].[BuyingGroups] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Customer].[BuyingGroups];
		ALTER TABLE [Customer].[BuyingGroups] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Customer].[CustomerCategories]
		ALTER TABLE [Customer].[CustomerCategories] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Customer].[CustomerCategories];
		ALTER TABLE [Customer].[CustomerCategories] WITH CHECK CHECK CONSTRAINT ALL; 

		-- [Customer].[Customers]
		ALTER TABLE [Customer].[Customers] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Customer].[Customers];
		ALTER TABLE [Customer].[Customers] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Customer].[People]
		ALTER TABLE [Customer].[People] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Customer].[People];
		ALTER TABLE [Customer].[People] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Geo].[DimCities]
		ALTER TABLE [Geo].[DimCities] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Geo].[DimCities];
		ALTER TABLE [Geo].[DimCities] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Geo].[DimCountries]
		ALTER TABLE [Geo].[DimCountries] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Geo].[DimCountries];
		ALTER TABLE [Geo].[DimCountries] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Geo].[DimStateProvinces]
		ALTER TABLE [Geo].[DimStateProvinces] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Geo].[DimStateProvinces];
		ALTER TABLE [Geo].[DimStateProvinces] WITH CHECK CHECK CONSTRAINT ALL; 

		-- [Payment].[CustomerTransactions]
		ALTER TABLE [Payment].[CustomerTransactions] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Payment].[CustomerTransactions];
		ALTER TABLE [Payment].[CustomerTransactions] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Payment].[PurchaseOrderLines]
		ALTER TABLE [Payment].[PurchaseOrderLines] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Payment].[PurchaseOrderLines];
		ALTER TABLE [Payment].[PurchaseOrderLines] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Payment].[PurchaseOrders]
		ALTER TABLE [Payment].[PurchaseOrders] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Payment].[PurchaseOrders];
		ALTER TABLE [Payment].[PurchaseOrders] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[Colors]
		ALTER TABLE [Product].[Colors] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[Colors];
		ALTER TABLE [Product].[Colors] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[DeliveryMethods]
		ALTER TABLE [Product].[DeliveryMethods] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[DeliveryMethods];
		ALTER TABLE [Product].[DeliveryMethods] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[InvoiceLines]
		ALTER TABLE [Product].[InvoiceLines] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[InvoiceLines];
		ALTER TABLE [Product].[InvoiceLines] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[Invoices]
		ALTER TABLE [Product].[Invoices] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[Invoices];
		ALTER TABLE [Product].[Invoices] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[OrderLines]
		ALTER TABLE [Product].[OrderLines] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[OrderLines];
		ALTER TABLE [Product].[OrderLines] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[PackageTypes]
		ALTER TABLE [Product].[PackageTypes] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[PackageTypes];
		ALTER TABLE [Product].[PackageTypes] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[PaymentMethods]
		ALTER TABLE [Product].[PaymentMethods] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[PaymentMethods];
		ALTER TABLE [Product].[PaymentMethods] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[StockItemHoldings]
		ALTER TABLE [Product].[StockItemHoldings] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[StockItemHoldings];
		TRUNCATE TABLE [Product].[StockItemHoldings];
		ALTER TABLE [Product].[StockItemHoldings] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[StockItems]
		ALTER TABLE [Product].[StockItems] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[StockItems];
		TRUNCATE TABLE [Product].[StockItems];
		ALTER TABLE [Product].[StockItems] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Product].[StockItemTransactions]
		ALTER TABLE [Product].[StockItemTransactions] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Product].[StockItemTransactions];
		ALTER TABLE [Product].[StockItemTransactions] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Supplier].[SupplierCategories]
		ALTER TABLE [Supplier].[SupplierCategories] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Supplier].[SupplierCategories];
		ALTER TABLE [Supplier].[SupplierCategories] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Supplier].[Suppliers]
		ALTER TABLE [Supplier].[Suppliers] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Supplier].[Suppliers];
		ALTER TABLE [Supplier].[Suppliers] WITH CHECK CHECK CONSTRAINT ALL; 
		
		-- [Supplier].[SupplierTransactions]
		ALTER TABLE [Supplier].[SupplierTransactions] NOCHECK CONSTRAINT ALL;
		DELETE FROM [Supplier].[SupplierTransactions];
		ALTER TABLE [Supplier].[SupplierTransactions] WITH CHECK CHECK CONSTRAINT ALL; 

	END TRY

	BEGIN CATCH

		DECLARE @ErrorMensaje nvarchar(126)
		DECLARE @ErrorSeveridad int
		DECLARE @ErrorEstado int

		SET @ErrorMensaje = error_message()
		SET @ErrorSeveridad = error_severity()
		SET @ErrorEstado = error_state()

		EXEC Errores.upErrores_Ins
		
		RAISERROR (@ErrorMensaje, @ErrorSeveridad, @ErrorEstado) 
		
	END CATCH

END
GO
PRINT N'Creando Procedimiento [dbo].[upDimGeo_Ins]...';


GO


/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla DimGeo de carga a DW.
*/

CREATE PROCEDURE [dbo].[upDimGeo_Ins]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		-- Limpieza previa
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimGeo;

		INSERT INTO WideWorldImportersGrupoDW.dbo.DimGeo (CountryID,
			CountryName,
			FormalName,
			--IsoAlpha3Code,
			--IsoNumericCode,
			CountryType,
			--LatestRecordedPopulation_Country,
			Continent,
			Region,
			Subregion,
			--Border_Country,
			--LastEditedBy_Country,
			--ValidFrom_Country,
			--ValidTo_Country,
			StateProvinceID,
			StateProvinceCode,
			StateProvinceName,
			CountryID_FK,
			SalesTerritory,
			Border_State,
			--LatestRecordedPopulation_State,
			--LastEditedBy_State,
			--ValidFrom_State,
			--ValidTo_State,
			CityID,
			CityName,
			StateProvinceID_FK,
			Location_City
			--LatestRecordedPopulation_City,
			--LastEditedBy_City,
			--ValidFrom_City,
			--ValidTo_City
			)
		SELECT c.CountryID,
			c.CountryName,
			c.FormalName,
			--c.IsoAlpha3Code,
			--c.IsoNumericCode,
			c.CountryType,
			--c.LatestRecordedPopulation,
			c.Continent,
			c.Region,
			c.Subregion,
			--c.Border,
			--c.LastEditedBy,
			--c.ValidFrom,
			--c.ValidTo,
			sp.StateProvinceID,
			sp.StateProvinceCode,
			sp.StateProvinceName,
			sp.CountryID,
			sp.SalesTerritory,
			sp.Border,
			--sp.LatestRecordedPopulation,
			--sp.LastEditedBy,
			--sp.ValidFrom,
			--sp.ValidTo,
			ci.CityID,
			ci.CityName,
			ci.StateProvinceID,
			ci.Location
			--ci.LatestRecordedPopulation,
			--ci.LastEditedBy,
			--ci.ValidFrom,
			--ci.ValidTo
		FROM [WideWorldImportersGrupoST].[Geo].[DimCountries] AS c
		LEFT JOIN [WideWorldImportersGrupoST].[Geo].[DimStateProvinces] AS sp
			ON sp.CountryID = c.CountryID
		LEFT JOIN [WideWorldImportersGrupoST].[Geo].[DimCities] AS ci
			ON ci.StateProvinceID = sp.StateProvinceID
		WHERE sp.StateProvinceID IS NOT NULL;

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
PRINT N'Creando Procedimiento [dbo].[upDimPayment_Ins]...';


GO

/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla DimPayment de carga a DW.
*/

CREATE PROCEDURE upDimPayment_Ins
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		-- Limpieza previa
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimPayment;

		INSERT INTO WideWorldImportersGrupoDW.dbo.DimPayment (PaymentMethodID
			,PaymentMethodName
			,LastEditedBy
			,ValidFrom
			,ValidTo)
		SELECT PaymentMethodID
			,PaymentMethodName
			,LastEditedBy
			,ValidFrom
			,ValidTo
		FROM WideWorldImportersGrupoST.[Product].[PaymentMethods]

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
PRINT N'Creando Procedimiento [dbo].[upDimPeopleEmploye_Customer_Ins]...';


GO




/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla DimPeopleEmploye y DimPeopleCustomer de carga a DW.
*/

CREATE PROCEDURE [dbo].[upDimPeopleEmploye_Customer_Ins]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		-- Limpieza previa de DimPeopleEmployee
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimPeopleEmployee;
		
		--INSERT a EMPLOYEE
		INSERT INTO WideWorldImportersGrupoDW.dbo.DimPeopleEmployee(PersonID
				,FullName
				--,PreferredName
				--,SearchName
				,IsPermittedToLogon
				--,LogonName
				,IsExternalLogonProvider
				--,HashedPassword
				,IsSystemUser
				--,IsEmployee
				,IsSalesperson
				,UserPreferences
				,PhoneNumber
				,FaxNumber
				,EmailAddress
				--,Photo
				--,CustomFields
				--,OtherLanguages
				--,LastEditedBy
				--,ValidFrom
				--,ValidTo
				)
		SELECT PersonID
				,FullName
				--,PreferredName
				--,SearchName
				,IsPermittedToLogon
				--,LogonName
				,IsExternalLogonProvider
				--,HashedPassword
				,IsSystemUser
				--,IsEmployee
				,IsSalesperson
				,UserPreferences
				,PhoneNumber
				,FaxNumber
				,EmailAddress
				--,Photo
				--,CustomFields
				--,OtherLanguages
				--,LastEditedBy
				--,ValidFrom
				--,ValidTo
		FROM [WideWorldImportersGrupoST].[Customer].[People]
		WHERE IsEmployee = 1;

		-- Limpieza previa de DimPeopleCustomer
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimPeopleCustomer;

		-- INSERT a CUSTOMER
		INSERT INTO WideWorldImportersGrupoDW.dbo.DimPeopleCustomer (PersonID
				,FullName
				--,PreferredName
				--,SearchName
				,PhoneNumber
				,FaxNumber
				,EmailAddress
				,IsSalesperson
				--,IsEmployee
				--,LastEditedBy
				--,ValidFrom
				--,ValidTo
				)
		SELECT PersonID
				,FullName
				--,PreferredName
				--,SearchName
				,PhoneNumber
				,FaxNumber
				,EmailAddress
				,IsSalesperson
				--,IsEmployee
				--,LastEditedBy
				--,ValidFrom
				--,ValidTo
		FROM [WideWorldImportersGrupoST].[Customer].[People]
		WHERE IsEmployee = 0;

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
PRINT N'Creando Procedimiento [dbo].[upDimProduct_Ins]...';


GO






/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla DimProduct de carga a DW.
*/

CREATE PROCEDURE [dbo].[upDimProduct_Ins]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		-- Limpieza previa
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimProduct;

		INSERT INTO WideWorldImportersGrupoDW.dbo.DimProduct (ProductID
					,StockItemName
					,SupplierID
					,ColorID
					,UnitPackageID
					,OuterPackageID
					,Brand
					,Size
					,LeadTimeDays
					,QuantityPerOuter
					,IsChillerStock
					--,Barcode
					,TaxRate
					,UnitPrice
					,RecommendedRetailPrice
					,TypicalWeightPerUnit
					--,MarketingComments
					--,InternalComments
					--,Photo
					--,CustomFields
					--,Tags
					,SearchDetails
					--,LastEditedBy
					--,ValidFrom
					--,ValidTo
					,ColorName)
		SELECT si.StockItemID
					,si.StockItemName
					,si.SupplierID
					,si.ColorID
					,si.UnitPackageID
					,si.OuterPackageID
					,si.Brand
					,si.Size
					,si.LeadTimeDays
					,si.QuantityPerOuter
					,si.IsChillerStock
					--,si.Barcode
					,si.TaxRate
					,si.UnitPrice
					,si.RecommendedRetailPrice
					,si.TypicalWeightPerUnit
					--,si.MarketingComments
					--,si.InternalComments
					--,si.Photo
					--,si.CustomFields
					--,si.Tags
					,si.SearchDetails
					--,si.LastEditedBy
					--,si.ValidFrom
					--,si.ValidTo
					,c.ColorName
		FROM [WideWorldImportersGrupoST].[Product].[StockItems] AS si
		LEFT JOIN [WideWorldImportersGrupoST].[Product].[Colors] AS c
			ON si.ColorID = c.ColorID
		--WHERE si.ColorID IS NOT NULL;

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
PRINT N'Creando Procedimiento [dbo].[upDimSuppier_Ins]...';


GO



/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla DimSuppier de carga a DW.
*/

CREATE PROCEDURE [dbo].[upDimSuppier_Ins]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		-- Limpieza previa
		DELETE FROM WideWorldImportersGrupoDW.dbo.DimSupplier;
		
		INSERT INTO WideWorldImportersGrupoDW.dbo.DimSupplier(SupplierCategoryID
				,SupplierCategoryName
				--,LastEditedBy_Category
				--,ValidFrom_Category
				--,ValidTo_Category
				,SupplierID
				,SupplierName
				,SupplierCategoryID_FK
				,PrimaryContactPersonID
				,AlternateContactPersonID
				,DeliveryMethodID
				,DeliveryCityID
				,PostalCityID
				,SupplierReference
				,BankAccountName
				,BankAccountBranch
				--,BankAccountCode
				,BankAccountNumber
				,BankInternationalCode
				,PaymentDays
				--,InternalComments
				--,PhoneNumber
				--,FaxNumber
				--,WebsiteURL
				,DeliveryAddressLine1
				,DeliveryAddressLine2
				,DeliveryPostalCode
				,DeliveryLocation
				,PostalAddressLine1
				,PostalAddressLine2
				,PostalPostalCode
				--,LastEditedBy
				--,ValidFrom
				--,ValidTo
				)
		SELECT sc.SupplierCategoryID
				,sc.SupplierCategoryName
				--,sc.LastEditedBy
				--,sc.ValidFrom
				--,sc.ValidTo
				,s.SupplierID
				,s.SupplierName
				,s.SupplierCategoryID
				,s.PrimaryContactPersonID
				,s.AlternateContactPersonID
				,s.DeliveryMethodID
				,s.DeliveryCityID
				,s.PostalCityID
				,s.SupplierReference
				,s.BankAccountName
				,s.BankAccountBranch
				--,s.BankAccountCode
				,s.BankAccountNumber
				,s.BankInternationalCode
				,s.PaymentDays
				--,s.InternalComments
				--,s.PhoneNumber
				--,s.FaxNumber
				--,s.WebsiteURL
				,s.DeliveryAddressLine1
				,s.DeliveryAddressLine2
				,s.DeliveryPostalCode
				,s.DeliveryLocation
				,s.PostalAddressLine1
				,s.PostalAddressLine2
				,s.PostalPostalCode
				--,s.LastEditedBy
				--,s.ValidFrom
				--,s.ValidTo
		FROM [WideWorldImportersGrupoST].[Supplier].[Suppliers] AS s
		INNER JOIN [Supplier].[SupplierCategories] AS sc
			ON sc.SupplierCategoryID = s.SupplierCategoryID
		
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
PRINT N'Creando Procedimiento [dbo].[upFactCobros_Ins]...';


GO



CREATE PROCEDURE [dbo].[upFactCobros_Ins]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        --Limpieza previa
        DELETE FROM [WideWorldImportersGrupoDW].[dbo].[FactCobros];

        INSERT INTO [WideWorldImportersGrupoDW].[dbo].[FactCobros]
               ([DateID], [PersonID], [PaymentMethodID], [InvoiceID],
                [TransactionAmount], [TaxAmount], [OutstandingBalance])
        SELECT
            DT.DateID,
            DC.PersonID AS CustomerID,
            ISNULL(DPM.PaymentMethodID, -1) AS PaymentMethodID,
            CT.InvoiceID,
            CT.TransactionAmount,
            CT.TaxAmount,
            CT.OutstandingBalance
        FROM [WideWorldImportersGrupoST].[Payment].[CustomerTransactions] AS CT
        INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimTiempo] AS DT
            ON DT.[Date] = CT.TransactionDate
        INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimPeopleCustomer] AS DC
            ON DC.PersonID = CT.CustomerID
        LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimPayment] AS DPM
            ON DPM.PaymentMethodID = CT.PaymentMethodID;

    END TRY
    BEGIN CATCH
        DECLARE @Error NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Error, 16, 1);
    END CATCH;
END;
GO
PRINT N'Creando Procedimiento [dbo].[upFactCompra_Ins]...';


GO






/*
	Fecha: 29/10/2025
	Desarrollador: Urso Ivan
	Comentario: SP de la tabla FactCompra de carga a DW.
*/

CREATE PROCEDURE [dbo].[upFactCompra_Ins]
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		INSERT INTO [WideWorldImportersGrupoDW].[dbo].[DimPayment] (PaymentMethodID, PaymentMethodName)
		SELECT -1, 'No Payment Registered'
		WHERE NOT EXISTS (
			SELECT 1 FROM [WideWorldImportersGrupoDW].[dbo].[DimPayment]
			WHERE PaymentMethodID = -1
		);

		--Limpieza previa
		DELETE FROM [WideWorldImportersGrupoDW].[dbo].[FactCompra];

		INSERT INTO [WideWorldImportersGrupoDW].[dbo].[FactCompra]
			   ([DateID]
			   ,[ProductID]
			   ,[SupplierID]
			   ,[CityID]
			   ,[PaymentMethodID]
			   ,[Quantity]
			   ,[UnitPrice]
			   ,[Total])
		SELECT
			DT.DateID,

			DP.ProductID,

			DS.SupplierID,

			DG.CityID,

			ISNULL(DPM.PaymentMethodID, -1) AS PaymentMethodID,

			POL.OrderedOuters AS Quantity,
			POL.ExpectedUnitPricePerOuter AS UnitPrice,
			(POL.OrderedOuters * POL.ExpectedUnitPricePerOuter) AS Total

		FROM [WideWorldImportersGrupoST].[Payment].[PurchaseOrderLines] AS POL
		INNER JOIN [WideWorldImportersGrupoST].[Payment].[PurchaseOrders] AS PO
			ON POL.PurchaseOrderID = PO.PurchaseOrderID
		INNER JOIN [WideWorldImportersGrupoST].[Supplier].[Suppliers] AS S
			ON PO.SupplierID = S.SupplierID

		LEFT JOIN  [WideWorldImportersGrupoST].[Supplier].[SupplierTransactions] AS STX
			ON STX.PurchaseOrderID = PO.PurchaseOrderID

		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimTiempo] AS DT
			ON DT.[Date] = PO.OrderDate
		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimProduct] AS DP
			ON DP.ProductID = POL.StockItemID
		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimSupplier] AS DS
			ON DS.SupplierID = S.SupplierID
		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimGeo] AS DG
			ON DG.CityID = S.DeliveryCityID
		LEFT  JOIN [WideWorldImportersGrupoDW].[dbo].[DimPayment] AS DPM
			ON DPM.PaymentMethodID = STX.PaymentMethodID;
    

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
PRINT N'Creando Procedimiento [dbo].[upFactVenta_Ins]...';


GO




/*
	Fecha: 11/11/2025
	Desarrollador: Urso Ivan
	Comentario: SP de carga a DW para la tabla FactVenta.
*/

CREATE PROCEDURE [dbo].[upFactVenta_Ins]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY


		--Limpieza previa
		DELETE FROM [WideWorldImportersGrupoDW].[dbo].[FactVenta];

		INSERT INTO [WideWorldImportersGrupoDW].[dbo].[FactVenta]
			   ([InvoiceID]
			   ,[DateID]
			   ,[ProductID]
			   ,[CityID]
			   ,[CustomerID]
			   ,[SalespersonID]
			   ,[PaymentMethodID]
			   ,[DeliveryMethodID]
			   ,[Quantity]
			   ,[UnitPrice]
			   ,[TaxAmount]
			   ,[LineProfit]
			   ,[ExtendedPrice])
		SELECT
			I.InvoiceID,

			DT.DateID,

			DP.ProductID,

			ISNULL(DG.CityID, -1) AS CityID,

			DC.PersonID,

			DE.PersonID AS SalespersonID,

			ISNULL(DPM.PaymentMethodID, -1) AS PaymentMethodID,

			ISNULL(I.DeliveryMethodID, -1) AS DeliveryMethodID,

			IL.Quantity,
			IL.UnitPrice,
			IL.TaxAmount,
			IL.LineProfit,
			IL.ExtendedPrice
		FROM [WideWorldImportersGrupoST].[Product].[InvoiceLines] AS IL
		INNER JOIN [WideWorldImportersGrupoST].[Product].[Invoices] AS I
			ON IL.InvoiceID = I.InvoiceID
		INNER JOIN [WideWorldImportersGrupoST].[Customer].[Customers] AS C
			ON I.CustomerID = C.CustomerID

		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimTiempo] AS DT
			ON DT.[Date] = I.InvoiceDate
		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimProduct] AS DP
			ON DP.ProductID = IL.StockItemID
		LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimGeo] AS DG
			ON DG.CityID = C.DeliveryCityID
		INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimPeopleCustomer] AS DC
			ON DC.PersonID = I.CustomerID
		LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimPeopleEmployee] AS DE
			ON DE.PersonID = I.SalespersonPersonID
		LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimPayment] AS DPM
			ON DPM.PaymentMethodID = -1
		LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimSupplier] AS DDM
			ON DDM.DeliveryMethodID = I.DeliveryMethodID;

	END TRY
	BEGIN CATCH
		DECLARE @ErrorMensaje NVARCHAR(4000);
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
