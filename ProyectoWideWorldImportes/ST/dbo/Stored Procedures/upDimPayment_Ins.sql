
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
