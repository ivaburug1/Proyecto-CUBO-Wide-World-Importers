READ ME BASE DE DATOS (Como usar GIT)



----------------Antes de empezar----------------

git cd "el directorio donde está la carpeta de BaseDeDatos guardada"

git stash        # Guarda todos tus cambios locales

git pull         # Trae los últimos cambios del repositorio remoto

----------------PARA SUBIR COSAS----------------

git add .                # Agrega todos los cambios nuevos

git add nombreArchivo    # Agrega un archivo específico

git commit -m "Fecha y hora del cambio (ej: 10/05 14:30) + Nombre" # Ejemplo: git commit -m "10/05/2025 - 14:30 - Ivan Urso"

git push                 # Sube los commits al repositorio remoto



----------------INTEGRANTES----------------

Urso Ivan Alejandro;

Perelmuter Dana;

Cuello de Sarro Rafael Luis;

Pylinski Natalie Lourdes;

Britez Leandro Ezequiel



----------------PROPOSITO----------------

Lograr un analisis integral, ordenado y colaborativo del desarrollo de la base de datos del proyecto.
Este repositorio permite mantener control de versiones, asegura la integridad del codigo SQL y facilitar el trabajo en equipo.

Cada integrande debe:

Actualizar su copia localn antes de realizar cambios

Registrar sus modificaciones con un commit descriptivo y fechado

Subir los cambios una vez verificado el correcto funcionamiento



----------------PASOS PARA LA EJECUCION----------------

A) Abrir la Solución:

1.Iniciar Visual Studio.

2.Ir a Archivo -> Abrir -> Proyecto o Solución.

3.Seleccionar el archivo .sln del proyecto.

4.Esperar a que Visual Studio cargue los proyectos asociados(ETL y los database project).



B) Crear los esquemas de las bases de datos:

1\. Publicar los database project con los nombres especificos "WideWorldImportersGrupoST" y "WideWorldImportersGrupoDW".

2.En el apartado de SSIS packages:

   - En el paquete E\_GrupoDIRN.

        - Hacer doble click sobre el execute sql task y cambiar tu conexión por la conexión local (ST creado en el paso anterior). Aca aparece la extración DIM.

        - En cada Data Float Task dentro de la extración de DIM, entrar a los OLE DB:

              - Para los OLE DB Source: Cambiar la conexión por la tuya (la descargada), elegir la tabla correspondiente y entrar a verificar que se hayan seleccionado todas las columnas.

              - Para los OLE DB Destination: Cambiar la conexión por la tuya (ST) elegir la tabla correspondiente y entrar a verificar que se hayan seleccionado todas las columnas.

   - En el paquete TL\_GrupoDIRN.

         - Hacer doble click sobre el execute sql task y cambiar tu conexión por la conexión local (DW).

         - En cada Data Float Task dentro de DIM DW y FACT DW:

              - Cambiar tu conexión a la de ST local creada en el paso 1.

3\. Ir al paquete ETL\_GrupoDIR y ejecutar el container ETL y apretar Execute Container.



C) Verificar la Conexión al Servidor de Analysis Services:

1.En el Explorador de Soluciones, localizar el proyecto del cubo.

2.Hacer clic derecho ->  Propiedades.

3.En la pestaña Deployment, revisar:

   - Target Server -> nombre de la instancia de Analysis Services.

   - Database -> nombre del cubo a desplegar.

4.Guardar los cambios.



D) Procesar el Cubo:

1\. Hacer los cambios de conexiones correspondientes.

2.En el Explorador de Soluciones, hacer clic derecho sobre el proyecto del cubo -> Deploy (porque el cubo ya esta armado en la solución).

3.Esperar que finalice la validación y el procesamiento.

4.Una vez desplegado, el cubo se podrá visualizar desde SQL Server Management Studio (SSMS).



E) Navegar el Cubo:

1.Abrir el Explorador de Cubos en Visual Studio o SSMS.

2.Ir a la pestaña Browser.

3.Seleccionar las Medidas y Dimensiones para explorar la información.



OPCIONAL: ANALISIS BI

F) Si se desea, es posible crear un analisis con graficos en power BI importando el cubo a PowerBI.

1\. En PowerBi se selecciona "Cargar sources".

2\. Se selecciona el archivo Data analisis services.

3\. Al cargarse, se selecciona el cubo y se presiona aceptar.

4\. Tras haberse cargado las tablas, seleccionar tablas y graficos a gusto.

5\. Crear los dashboards.





----------------LINK DE PRESENTACION CANVA----------------

https://www.canva.com/design/DAG4nzmcm4I/g\_tQat7fy2Z53smzbdwNZA/edit

