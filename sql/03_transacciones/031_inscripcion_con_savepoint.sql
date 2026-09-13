--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 031_inscripcion_con_savepoint.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Ejecutar una inscripcion utilizando un SAVEPOINT
--                  para establecer un punto intermedio dentro de la
--                  transaccion.
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
--   - Solicitud creada inicialmente como PENDIENTE.
--   - SAVEPOINT creado despues de registrar la solicitud.
--   - Inscripcion creada.
--   - CUPO_DISPONIBLE reducido de 1 a 0.
--   - Solicitud actualizada a PROCESADA.
--   - Transaccion confirmada mediante COMMIT.
--
-- NOTA:
--   El SAVEPOINT permite definir un punto intermedio dentro de una
--   transaccion. En 032_rollback_parcial.sql se demostrara como
--   regresar a dicho punto mediante ROLLBACK TO SAVEPOINT.
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
-- 6. ACTUALIZAR CUPO
--==============================================================================

UPDATE ACADEMICO_G4.SECCION
SET CUPO_DISPONIBLE = CUPO_DISPONIBLE - 1
WHERE ID_SECCION = 1;


--==============================================================================
-- 7. ACTUALIZAR SOLICITUD
--==============================================================================

UPDATE ACADEMICO_G4.SOLICITUD_INSCRIPCION
SET ESTADO = 'PROCESADA',
    FECHA_PROCESADA = SYSTIMESTAMP,
    MENSAJE_RESULTADO = 'INSCRIPCION REALIZADA CON SAVEPOINT'
WHERE ID_SOLICITUD = 1;


--==============================================================================
-- 8. VALIDAR ANTES DEL COMMIT
--==============================================================================

SELECT ID_SOLICITUD,
       ESTADO,
       MENSAJE_RESULTADO
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
-- 9. CONFIRMAR TRANSACCION
--==============================================================================

COMMIT;


--==============================================================================
-- CONCLUSION ESPERADA
--==============================================================================
--
-- El SAVEPOINT SP_SOLICITUD_CREADA establecio un punto intermedio
-- dentro de la transaccion.
--
-- Como no ocurrio ningun error, la transaccion continuo normalmente
-- hasta finalizar con COMMIT.
--
-- Al ejecutarse COMMIT, los cambios quedan confirmados y el SAVEPOINT
-- deja de estar disponible.
--==============================================================================