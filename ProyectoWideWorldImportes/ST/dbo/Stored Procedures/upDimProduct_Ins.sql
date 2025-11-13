





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
