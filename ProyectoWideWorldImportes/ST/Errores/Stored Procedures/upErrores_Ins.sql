


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
