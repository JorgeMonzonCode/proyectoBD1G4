--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 004_permisos.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Otorgar permisos sobre los objetos del esquema
--                  ACADEMICO_G4 a los usuarios auxiliares del proyecto.
--
-- EJECUTAR COMO  : Usuario propietario de las tablas.
--                  Usuario: ACADEMICO_G4
--
-- ESQUEMA ACTUAL : ACADEMICO_G4
--
-- PRECONDICIONES :
--   1. Oracle Database 21c XE debe estar iniciado.
--   2. Debe existir el esquema ACADEMICO_G4.
--   3. Deben existir las 10 tablas del modelo base.
--   4. Deben existir los usuarios:
--        - USR_CONSULTA_G4
--        - USR_TRANSACCION_G4
--
-- DEPENDENCIAS   :
--   001_tablespace.sql
--   002_schema.sql
--   003_usuarios.sql
--   modelo_v01_generado.sql
--
-- RESULTADO ESPERADO:
--   - USR_CONSULTA_G4 con permisos de solo lectura.
--   - USR_TRANSACCION_G4 con permisos de lectura y operaciones
--     relacionadas con el proceso de inscripcion.
--
-- SIGUIENTE PASO:
--   Validar los permisos conectandose con ambos usuarios.
--==============================================================================

--==============================================================================
-- NOTAS SOBRE LOS PERMISOS
--==============================================================================
--
-- USR_CONSULTA_G4:
--   - Tiene unicamente permiso SELECT sobre las tablas del sistema.
--   - Se utiliza para consultas y validaciones sin modificar informacion.
--
-- USR_TRANSACCION_G4:
--   - Tiene SELECT sobre las tablas necesarias para consultar informacion
--     academica durante el proceso de inscripcion.
--
--   - Tiene INSERT, UPDATE y DELETE sobre INSCRIPCION porque este usuario
--     participara en las operaciones transaccionales de matricula.
--
--   - Tiene INSERT, UPDATE y DELETE sobre SOLICITUD_INSCRIPCION porque
--     las solicitudes pueden crearse, procesarse, actualizarse o eliminarse
--     durante las pruebas del proyecto.
--
--   - Tiene UPDATE sobre SECCION debido a que el proceso de inscripcion
--     necesita modificar el CUPO_DISPONIBLE.
--
--   - NO tiene INSERT, UPDATE ni DELETE sobre AUDITORIA_INSCRIPCION.
--     Esta tabla no debe ser modificada manualmente por el usuario
--     transaccional.
--
--   - AUDITORIA_INSCRIPCION sera alimentada posteriormente mediante
--     triggers de auditoria, de forma automatica.
--
--   - Tampoco se otorgan permisos de modificacion sobre CARRERA, CURSO,
--     DOCENTE, ESTUDIANTE, PERIODO_ACADEMICO ni HORARIO porque estos datos
--     son considerados informacion administrativa y no forman parte de
--     una transaccion normal de inscripcion.
--
-- PRINCIPIO APLICADO:
--   Se utiliza el principio de minimo privilegio, otorgando a cada usuario
--   solamente los permisos necesarios para cumplir su funcion.
--==============================================================================

--==============================================================================
-- 1. PERMISOS PARA USR_CONSULTA_G4
--    Usuario destinado exclusivamente a consultas.
--==============================================================================

GRANT SELECT ON CARRERA TO USR_CONSULTA_G4;
GRANT SELECT ON ESTUDIANTE TO USR_CONSULTA_G4;
GRANT SELECT ON DOCENTE TO USR_CONSULTA_G4;
GRANT SELECT ON CURSO TO USR_CONSULTA_G4;
GRANT SELECT ON PERIODO_ACADEMICO TO USR_CONSULTA_G4;
GRANT SELECT ON SECCION TO USR_CONSULTA_G4;
GRANT SELECT ON HORARIO TO USR_CONSULTA_G4;
GRANT SELECT ON SOLICITUD_INSCRIPCION TO USR_CONSULTA_G4;
GRANT SELECT ON INSCRIPCION TO USR_CONSULTA_G4;
GRANT SELECT ON AUDITORIA_INSCRIPCION TO USR_CONSULTA_G4;


--==============================================================================
-- 2. PERMISOS DE CONSULTA PARA USR_TRANSACCION_G4
--==============================================================================

GRANT SELECT ON CARRERA TO USR_TRANSACCION_G4;
GRANT SELECT ON ESTUDIANTE TO USR_TRANSACCION_G4;
GRANT SELECT ON DOCENTE TO USR_TRANSACCION_G4;
GRANT SELECT ON CURSO TO USR_TRANSACCION_G4;
GRANT SELECT ON PERIODO_ACADEMICO TO USR_TRANSACCION_G4;
GRANT SELECT ON SECCION TO USR_TRANSACCION_G4;
GRANT SELECT ON HORARIO TO USR_TRANSACCION_G4;
GRANT SELECT ON SOLICITUD_INSCRIPCION TO USR_TRANSACCION_G4;
GRANT SELECT ON INSCRIPCION TO USR_TRANSACCION_G4;
GRANT SELECT ON AUDITORIA_INSCRIPCION TO USR_TRANSACCION_G4;


--==============================================================================
-- 3. PERMISOS TRANSACCIONALES
--==============================================================================

-- Solicitudes de inscripcion
GRANT INSERT, UPDATE, DELETE
ON SOLICITUD_INSCRIPCION
TO USR_TRANSACCION_G4;

-- Inscripciones
GRANT INSERT, UPDATE, DELETE
ON INSCRIPCION
TO USR_TRANSACCION_G4;

-- Actualizacion de cupos de las secciones
GRANT UPDATE
ON SECCION
TO USR_TRANSACCION_G4;


--==============================================================================
-- 4. VALIDAR PERMISOS OTORGADOS
--==============================================================================

SELECT grantee,
       table_name,
       privilege
FROM user_tab_privs_made
WHERE grantee IN (
    'USR_CONSULTA_G4',
    'USR_TRANSACCION_G4'
)
ORDER BY grantee,
         table_name,
         privilege;