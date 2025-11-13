


CREATE PROCEDURE [dbo].[upFactCobros_Ins]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        --Limpieza previa
        DELETE FROM [WideWorldImportersGrupoDW].[dbo].[FactCobros];

        INSERT INTO [WideWorldImportersGrupoDW].[dbo].[FactCobros]
               ([DateID], [PersonID], [PaymentMethodID], [InvoiceID],
                [TransactionAmount], [TaxAmount], [OutstandingBalance])
        SELECT
            DT.DateID,
            DC.PersonID AS CustomerID,
            ISNULL(DPM.PaymentMethodID, -1) AS PaymentMethodID,
            CT.InvoiceID,
            CT.TransactionAmount,
            CT.TaxAmount,
            CT.OutstandingBalance
        FROM [WideWorldImportersGrupoST].[Payment].[CustomerTransactions] AS CT
        INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimTiempo] AS DT
            ON DT.[Date] = CT.TransactionDate
        INNER JOIN [WideWorldImportersGrupoDW].[dbo].[DimPeopleCustomer] AS DC
            ON DC.PersonID = CT.CustomerID
        LEFT JOIN [WideWorldImportersGrupoDW].[dbo].[DimPayment] AS DPM
            ON DPM.PaymentMethodID = CT.PaymentMethodID;

    END TRY
    BEGIN CATCH
        DECLARE @Error NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@Error, 16, 1);
    END CATCH;
END;
