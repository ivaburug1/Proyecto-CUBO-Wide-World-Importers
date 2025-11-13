



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
