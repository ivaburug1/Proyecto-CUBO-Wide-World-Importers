

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
