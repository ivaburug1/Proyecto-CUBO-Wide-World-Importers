CREATE TABLE [Errores].[Errores] (
    [ErrorID]       INT             IDENTITY (1, 1) NOT NULL,
    [FechaError]    DATETIME        CONSTRAINT [DF_Errores_FechaError] DEFAULT (getdate()) NOT NULL,
    [Usuario]       NVARCHAR (128)  NULL,
    [Aplicacion]    NVARCHAR (128)  NULL,
    [Numero]        INT             NULL,
    [Severidad]     INT             NULL,
    [Estado]        INT             NULL,
    [Procedimiento] NVARCHAR (128)  NULL,
    [Linea]         INT             NULL,
    [Mensaje]       NVARCHAR (4000) NULL,
    [Paquete]       NVARCHAR (128)  NULL,
    [NumPaquete]    NVARCHAR (128)  NULL,
    [NumContenedor] NVARCHAR (128)  NULL,
    [Tarea]         NVARCHAR (128)  NULL,
    [NumTarea]      NVARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([ErrorID] ASC)
);

