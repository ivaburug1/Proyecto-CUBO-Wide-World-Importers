



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
