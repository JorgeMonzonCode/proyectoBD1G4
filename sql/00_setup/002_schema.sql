--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 002_schema.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Crear el usuario propietario del esquema principal
--                  del sistema academico.
--
-- EJECUTAR COMO  : Usuario con rol DBA o privilegio CREATE USER.
--                  Ambiente de desarrollo: MONZON.
--
-- ESQUEMA ACTUAL : MONZON
--
-- PRECONDICIONES :
--   1. Oracle Database 21c XE debe estar iniciado.
--   2. Debe existir el tablespace ACADEMICO_DATA.
--   3. El usuario ejecutor debe poder crear usuarios.
--   4. El usuario ACADEMICO_G4 no debe existir previamente.
--
-- DEPENDENCIAS   :
--   001_tablespace.sql
--
-- RESULTADO ESPERADO:
--   - Usuario ACADEMICO_G4 creado.
--   - Tablespace por defecto: ACADEMICO_DATA.
--   - Cuota ilimitada sobre ACADEMICO_DATA.
--   - Permisos basicos para conectarse y crear objetos.
--
-- NO EJECUTAR SI :
--   - El usuario ACADEMICO_G4 ya existe.
--
-- SIGUIENTE SCRIPT:
--   003_usuarios.sql
--==============================================================================


--==============================================================================
-- 1. CREAR USUARIO / ESQUEMA PROPIETARIO
--==============================================================================

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER ACADEMICO_G4
IDENTIFIED BY Manager1
DEFAULT TABLESPACE ACADEMICO_DATA;


--==============================================================================
-- 2. ASIGNAR CUOTA SOBRE EL TABLESPACE
--==============================================================================

ALTER USER ACADEMICO_G4
QUOTA UNLIMITED ON ACADEMICO_DATA;


--==============================================================================
-- 3. OTORGAR PRIVILEGIOS BASICOS
--==============================================================================

GRANT CONNECT, RESOURCE TO ACADEMICO_G4;


--==============================================================================
-- 4. VALIDAR CREACION DEL USUARIO
--==============================================================================

SELECT username,
       default_tablespace,
       account_status
FROM dba_users
WHERE username = 'ACADEMICO_G4';


--==============================================================================
-- 5. VALIDAR CUOTA ASIGNADA
--==============================================================================

SELECT username,
       tablespace_name,
       max_bytes
FROM dba_ts_quotas
WHERE username = 'ACADEMICO_G4';