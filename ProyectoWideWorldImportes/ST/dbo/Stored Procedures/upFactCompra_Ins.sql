





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
