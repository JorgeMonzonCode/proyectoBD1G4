--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : pruebaPermisosTransaccion.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Validar los permisos asignados al usuario
--                  USR_TRANSACCION_G4.
--
-- EJECUTAR COMO  : USR_TRANSACCION_G4
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Deben existir los datos mínimos de prueba.
--   3. Debe haberse ejecutado 004_permisos.sql.
--
-- RESULTADO ESPERADO:
--   - Puede consultar información.
--   - Puede modificar objetos relacionados con inscripción.
--   - No puede modificar tablas administrativas como CARRERA.
--==============================================================================


--==============================================================================
-- 1. CONFIRMAR USUARIO ACTUAL
--==============================================================================

SELECT USER
FROM dual;


--==============================================================================
-- 2. VALIDAR CONSULTA PERMITIDA
--==============================================================================

SELECT *
FROM ACADEMICO_G4.SECCION;


--==============================================================================
-- 3. INSERTAR SOLICITUD DE INSCRIPCION
--==============================================================================

INSERT INTO ACADEMICO_G4.SOLICITUD_INSCRIPCION
(
    ID_SOLICITUD,
    ID_ESTUDIANTE,
    ID_SECCION,
    ESTADO
)
VALUES
(
    1,
    1,
    1,
    'PENDIENTE'
);


--==============================================================================
-- 4. VALIDAR SOLICITUD INSERTADA
--==============================================================================

SELECT *
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 5. ACTUALIZAR SOLICITUD
--==============================================================================

UPDATE ACADEMICO_G4.SOLICITUD_INSCRIPCION
SET ESTADO = 'PROCESANDO'
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 6. ACTUALIZAR CUPO DE LA SECCION
--==============================================================================

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = 0
WHERE ID_SECCION = 1;


--==============================================================================
-- 7. VALIDAR CAMBIOS
--==============================================================================

SELECT ID_SOLICITUD,
       ESTADO
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;

SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- 8. PROBAR MODIFICACION NO PERMITIDA
--==============================================================================

-- RESULTADO ESPERADO:
-- ORA-01031: insufficient privileges

UPDATE ACADEMICO_G4.CARRERA
SET NOMBRE = 'PRUEBA NO PERMITIDA'
WHERE ID_CARRERA = 1;


--==============================================================================
-- 9. LIMPIAR DATOS DE LA PRUEBA
--==============================================================================

DELETE FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = 1
WHERE ID_SECCION = 1;

COMMIT;


--==============================================================================
-- CONCLUSION ESPERADA
--==============================================================================
--
-- USR_TRANSACCION_G4 puede modificar datos asociados al proceso
-- de inscripción, pero no puede modificar tablas administrativas.
--
-- Esto valida el principio de mínimo privilegio.
--==============================================================================