--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 001_tablespace.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Crear el tablespace principal para almacenar
--                  los objetos del sistema academico.
--
-- EJECUTAR COMO  : Usuario con rol DBA o privilegio CREATE TABLESPACE.
--                  Ambiente de desarrollo: MONZON.
--
-- ESQUEMA ACTUAL : No aplica.
--                  Este script crea infraestructura a nivel de base de datos.
--
-- PRECONDICIONES :
--   1. Oracle Database 21c XE debe estar iniciado.
--   2. El usuario ejecutor debe tener rol DBA o CREATE TABLESPACE.
--   3. Debe existir la ruta /opt/oracle/oradata/XE/.
--   4. El tablespace ACADEMICO_DATA no debe existir previamente.
--
-- DEPENDENCIAS   : Ninguna.
--
-- RESULTADO ESPERADO:
--   - Tablespace ACADEMICO_DATA creado correctamente.
--   - Datafile academico_data01.dbf creado.
--   - Tamaño inicial de 100 MB.
--   - AUTOEXTEND habilitado.
--   - Incremento automatico de 10 MB.
--
-- NO EJECUTAR SI :
--   - El tablespace ACADEMICO_DATA ya existe.
--
-- SIGUIENTE SCRIPT:
--   002_schema.sql
--==============================================================================


--==============================================================================
-- 1. CONSULTAR UBICACION DE LOS DATAFILES DEL SERVIDOR
--==============================================================================

SELECT name
FROM v$datafile;


--==============================================================================
-- 2. CREAR TABLESPACE DEL PROYECTO
--==============================================================================

CREATE TABLESPACE ACADEMICO_DATA
DATAFILE '/opt/oracle/oradata/XE/academico_data01.dbf'
SIZE 100M
AUTOEXTEND ON
NEXT 10M;


--==============================================================================
-- 3. VALIDAR CREACION DEL TABLESPACE
--==============================================================================

SELECT tablespace_name,
       status
FROM dba_tablespaces
WHERE tablespace_name = 'ACADEMICO_DATA';


--==============================================================================
-- 4. VALIDAR DATAFILE ASOCIADO
--==============================================================================

SELECT file_name,
       tablespace_name,
       bytes / 1024 / 1024 AS MB
FROM dba_data_files
WHERE tablespace_name = 'ACADEMICO_DATA';