


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
