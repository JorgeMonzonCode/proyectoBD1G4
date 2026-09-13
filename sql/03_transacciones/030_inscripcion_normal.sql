--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 030_inscripcion_normal.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Ejecutar una inscripcion normal de un estudiante,
--                  registrando la solicitud, la inscripcion y la
--                  actualizacion del cupo disponible.
--
-- EJECUTAR COMO  : USR_TRANSACCION_G4
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Deben haberse cargado los datos minimos de prueba.
--   3. Debe existir el estudiante con ID_ESTUDIANTE = 1.
--   4. Debe existir la seccion con ID_SECCION = 1.
--   5. La seccion debe estar ABIERTA.
--   6. La seccion debe tener CUPO_DISPONIBLE = 1.
--   7. No debe existir una inscripcion previa del estudiante 1
--      en la seccion 1.
--
-- DEPENDENCIAS   :
--   sql/02_datos_prueba/020_datos_minimos.sql
--   sql/00_setup/004_permisos.sql
--
-- RESULTADO ESPERADO:
--   - Solicitud de inscripcion creada.
--   - Inscripcion creada.
--   - CUPO_DISPONIBLE reducido de 1 a 0.
--   - Solicitud actualizada a PROCESADA.
--   - Cambios confirmados mediante COMMIT.
--
-- NOTA:
--   Esta prueba representa el flujo normal de una transaccion.
--   En scripts posteriores se incorporaran SAVEPOINT y ROLLBACK.
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
-- 2. CONSULTAR ESTADO INICIAL DE LA SECCION
--==============================================================================

SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;


--==============================================================================
-- 3. CREAR SOLICITUD DE INSCRIPCION
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
-- 4. CREAR INSCRIPCION
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
-- 5. ACTUALIZAR CUPO DISPONIBLE
--==============================================================================

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = CUPO_DISPONIBLE - 1
WHERE ID_SECCION = 1;


--==============================================================================
-- 6. ACTUALIZAR SOLICITUD
--==============================================================================

UPDATE ACADEMICO_G4.SOLICITUD_INSCRIPCION
SET ESTADO = 'PROCESADA',
    FECHA_PROCESADA = SYSTIMESTAMP,
    MENSAJE_RESULTADO = 'INSCRIPCION REALIZADA CORRECTAMENTE'
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 7. CONFIRMAR TRANSACCION
--==============================================================================

COMMIT;


--==============================================================================
-- 8. VALIDAR RESULTADO FINAL
--==============================================================================

SELECT ID_SOLICITUD,
       ID_ESTUDIANTE,
       ID_SECCION,
       ESTADO,
       FECHA_PROCESADA,
       MENSAJE_RESULTADO
FROM ACADEMICO_G4.SOLICITUD_INSCRIPCION
WHERE ID_SOLICITUD = 1;


SELECT ID_INSCRIPCION,
       ID_ESTUDIANTE,
       ID_SECCION,
       ESTADO,
       FECHA_INSCRIPCION
FROM ACADEMICO_G4.INSCRIPCION
WHERE ID_INSCRIPCION = 1;


SELECT ID_SECCION,
       CUPO_MAXIMO,
       CUPO_DISPONIBLE,
       ESTADO
FROM ACADEMICO_G4.SECCION
WHERE ID_SECCION = 1;