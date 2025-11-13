



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
