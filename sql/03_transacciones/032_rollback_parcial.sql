--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 032_rollback_parcial.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Demostrar el uso de ROLLBACK TO SAVEPOINT para revertir
--                  parcialmente una transaccion de inscripcion.
--
-- EJECUTAR COMO  : USR_TRANSACCION_G4
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Deben haberse cargado los datos minimos de prueba.
--   3. Debe haberse ejecutado 021_reset_escenario_inscripcion.sql.
--   4. Debe existir el estudiante con ID_ESTUDIANTE = 1.
--   5. Debe existir la seccion con ID_SECCION = 1.
--   6. La seccion debe estar ABIERTA.
--   7. La seccion debe tener CUPO_DISPONIBLE = 1.
--
-- DEPENDENCIAS   :
--   sql/02_datos_prueba/020_datos_minimos.sql
--   sql/02_datos_prueba/021_reset_escenario_inscripcion.sql
--   sql/00_setup/004_permisos.sql
--
-- RESULTADO ESPERADO:
--   - La solicitud se crea y permanece.
--   - Se crea un SAVEPOINT despues de registrar la solicitud.
--   - Se crea temporalmente una inscripcion.
--   - El cupo se reduce temporalmente de 1 a 0.
--   - ROLLBACK TO SAVEPOINT revierte la inscripcion y el cambio de cupo.
--   - La solicitud permanece porque fue creada antes del SAVEPOINT.
--   - La transaccion restante se confirma mediante COMMIT.
--
-- NOTA:
--   Esta prueba demuestra un ROLLBACK parcial. No se revierte toda la
--   transaccion, solamente las operaciones realizadas despues del SAVEPOINT.
-- NOTA:
--   Antes de repetir esta prueba, resetear el escenario ejecutando:
--   sql/02_datos_prueba/021_reset_escenario_inscripcion.sql
--   Ejecutar dicho script como USR_TRANSACCION_G4.
--==============================================================================


--==============================================================================
-- 1. CONFIRMAR USUARIO ACTUAL
--==============================================================================

SELECT USER
FROM dual;


--==============================================================================
-- 2. VALIDAR ESTADO INICIAL
--==============================================================================

SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- 3. CREAR SOLICITUD
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
-- 4. CREAR SAVEPOINT
--==============================================================================

SAVEPOINT SP_SOLICITUD_CREADA;


--==============================================================================
-- 5. CREAR INSCRIPCION
--==============================================================================

INSERT INTO ACADEMICO_G4.INSCRIPCION
(
    ID_INSCRIPCION,
    ID_ESTUDIANTE,
    ID_SECCION,
    ESTADO
)
VALUES
(
    1,
    1,
    1,
    'ACTIVA'
);


--==============================================================================
-- 6. REDUCIR CUPO DISPONIBLE
--==============================================================================

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = CUPO_DISPONIBLE - 1
WHERE ID_SECCION = 1;


--==============================================================================
-- 7. VALIDAR CAMBIOS ANTES DEL ROLLBACK
--==============================================================================

SELECT ID_SOLICITUD,
       ESTADO
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


SELECT ID_INSCRIPCION,
       ID_ESTUDIANTE,
       ID_SECCION,
       ESTADO
FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- 8. REALIZAR ROLLBACK PARCIAL
--==============================================================================

ROLLBACK TO SP_SOLICITUD_CREADA;


--==============================================================================
-- 9. VALIDAR RESULTADO DESPUES DEL ROLLBACK
--==============================================================================

-- La solicitud debe continuar existiendo porque fue creada
-- antes del SAVEPOINT.

SELECT ID_SOLICITUD,
       ID_ESTUDIANTE,
       ID_SECCION,
       ESTADO
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


-- La inscripcion debe haber desaparecido.

SELECT COUNT(*) AS TOTAL_INSCRIPCIONES
FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


-- El cupo debe regresar a 1.

SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- 10. ACTUALIZAR RESULTADO DE LA SOLICITUD
--==============================================================================

UPDATE ACADEMICO_G4.SOLICITUD_INSCRIPCION
SET ESTADO = 'RECHAZADA',
    FECHA_PROCESADA = SYSTIMESTAMP,
    MENSAJE_RESULTADO = 'OPERACION REVERTIDA MEDIANTE ROLLBACK PARCIAL'
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 11. CONFIRMAR CAMBIOS QUE PERMANECIERON
--==============================================================================

COMMIT;


--==============================================================================
-- 12. VALIDACION FINAL
--==============================================================================

SELECT ID_SOLICITUD,
       ESTADO,
       FECHA_PROCESADA,
       MENSAJE_RESULTADO
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


SELECT COUNT(*) AS TOTAL_INSCRIPCIONES
FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- CONCLUSION ESPERADA
--==============================================================================
--
-- La solicitud fue creada antes del SAVEPOINT y por eso permanecio.
--
-- La inscripcion y la reduccion del cupo fueron realizadas despues
-- del SAVEPOINT y fueron revertidas mediante:
--
--   ROLLBACK TO SP_SOLICITUD_CREADA;
--
-- El resultado final esperado es:
--
--   SOLICITUD_INSCRIPCION = RECHAZADA
--   TOTAL_INSCRIPCIONES   = 0
--   CUPO_DISPONIBLE       = 1
--
-- Esto demuestra que Oracle permite revertir parcialmente una
-- transaccion sin perder las operaciones realizadas antes del SAVEPOINT.
--==============================================================================