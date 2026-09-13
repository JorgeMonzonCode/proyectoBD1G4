--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 021_reset_escenario_inscripcion.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Restaurar el escenario base de inscripcion para poder
--                  repetir pruebas transaccionales y de concurrencia.
--
-- EJECUTAR COMO  : USR_TRANSACCION_G4
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Debe haberse ejecutado previamente una prueba de inscripcion.
--   3. El usuario debe tener permisos DELETE sobre INSCRIPCION y
--      SOLICITUD_INSCRIPCION, y UPDATE sobre SECCION.
--
-- RESULTADO ESPERADO:
--   - Sin inscripcion activa para estudiante 1 / seccion 1.
--   - Sin solicitud ID_SOLICITUD = 1.
--   - CUPO_DISPONIBLE restaurado a 1.
--
-- NOTA:
--   Este script esta pensado para ambiente de pruebas.
--   No debe utilizarse como proceso funcional del sistema.
--==============================================================================


--==============================================================================
-- 1. ELIMINAR INSCRIPCION DE PRUEBA
--==============================================================================

DELETE FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


--==============================================================================
-- 2. ELIMINAR SOLICITUD DE PRUEBA
--==============================================================================

DELETE FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 3. RESTAURAR CUPO DE LA SECCION
--==============================================================================

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = 1
WHERE ID_SECCION = 1;


--==============================================================================
-- 4. CONFIRMAR CAMBIOS
--==============================================================================

COMMIT;


--==============================================================================
-- 5. VALIDAR ESCENARIO RESTAURADO
--==============================================================================

SELECT COUNT(*) AS TOTAL_INSCRIPCIONES
FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


SELECT COUNT(*) AS TOTAL_SOLICITUDES
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;