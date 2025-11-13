





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
