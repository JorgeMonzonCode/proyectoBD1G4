--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 003_usuarios.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Crear los usuarios auxiliares que se utilizaran para
--                  pruebas de consulta y operaciones transaccionales.
--
-- EJECUTAR COMO  : Usuario con rol DBA o privilegio CREATE USER.
--                  Ambiente de desarrollo: MONZON.
--
-- ESQUEMA ACTUAL : MONZON
--
-- PRECONDICIONES :
--   1. Oracle Database 21c XE debe estar iniciado.
--   2. Debe existir el tablespace ACADEMICO_DATA.
--   3. Debe existir el esquema propietario ACADEMICO_G4.
--   4. Los usuarios USR_CONSULTA_G4 y USR_TRANSACCION_G4
--      no deben existir previamente.
--
-- DEPENDENCIAS   :
--   001_tablespace.sql
--   002_schema.sql
--
-- RESULTADO ESPERADO:
--   - Usuario USR_CONSULTA_G4 creado.
--   - Usuario USR_TRANSACCION_G4 creado.
--   - Ambos usuarios con ACADEMICO_DATA como tablespace por defecto.
--   - Ambos usuarios con permiso para iniciar sesion.
--
-- NO EJECUTAR SI :
--   - Alguno de los usuarios ya existe.
--
-- SIGUIENTE SCRIPT:
-- SIGUIENTE SCRIPT:
--   ../../model/data_modeler/gestion_academica_grupo4/ddl/modelo_v01_generado.sql
--   Ejecutar con el usuario ACADEMICO_G4. para crear
--   las tablas, restricciones y relaciones del modelo base.
--==============================================================================


--==============================================================================
-- 1. HABILITAR CREACION DE USUARIOS EN ORACLE XE
--==============================================================================

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


--==============================================================================
-- 2. CREAR USUARIO DE CONSULTA
--==============================================================================

CREATE USER USR_CONSULTA_G4
IDENTIFIED BY Manager1
DEFAULT TABLESPACE ACADEMICO_DATA;


--==============================================================================
-- 3. CREAR USUARIO TRANSACCIONAL
--==============================================================================

CREATE USER USR_TRANSACCION_G4
IDENTIFIED BY Manager1
DEFAULT TABLESPACE ACADEMICO_DATA;


--==============================================================================
-- 4. OTORGAR PERMISO DE CONEXION
--==============================================================================

GRANT CONNECT TO USR_CONSULTA_G4;

GRANT CONNECT TO USR_TRANSACCION_G4;


--==============================================================================
-- 5. VALIDAR CREACION DE LOS USUARIOS
--==============================================================================

SELECT username,
       default_tablespace,
       account_status
FROM dba_users
WHERE username IN (
    'USR_CONSULTA_G4',
    'USR_TRANSACCION_G4'
)
ORDER BY username;