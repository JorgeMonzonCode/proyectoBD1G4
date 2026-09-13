--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : pruebaPermisosUsuarios.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Validar los permisos asignados a los usuarios auxiliares
--                  del sistema academico.
--
-- PRUEBA 1       : USR_CONSULTA_G4
--                  Debe poder consultar informacion.
--                  No debe poder insertar, actualizar ni eliminar datos.
--
-- PRUEBA 2       : USR_TRANSACCION_G4
--                  Se validara posteriormente con operaciones permitidas.
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Deben existir las tablas del modelo base.
--   3. Debe haberse ejecutado 004_permisos.sql.
--==============================================================================


--==============================================================================
-- PRUEBA 1 - USUARIO DE CONSULTA
-- EJECUTAR COMO: USR_CONSULTA_G4
--==============================================================================

-- 1. CONFIRMAR USUARIO ACTUAL
SELECT USER
FROM dual;


-- 2. PROBAR CONSULTA PERMITIDA
-- RESULTADO ESPERADO:
-- La consulta debe ejecutarse correctamente.

SELECT *
FROM ACADEMICO_G4.CARRERA;


-- 3. PROBAR INSERCION NO PERMITIDA
-- RESULTADO ESPERADO:
-- Oracle debe rechazar la operacion por falta de privilegios.
-- Error esperado: ORA-01031: insufficient privileges

INSERT INTO ACADEMICO_G4.CARRERA
(
    ID_CARRERA,
    CODIGO_CARRERA,
    NOMBRE,
    ESTADO
)
VALUES
(
    999,
    'TEST',
    'CARRERA DE PRUEBA',
    'ACTIVA'
);


--==============================================================================
-- CONCLUSION ESPERADA
--==============================================================================
--
-- Si SELECT funciona y el INSERT es rechazado, se confirma que
-- USR_CONSULTA_G4 posee permisos de solo lectura sobre el esquema.
--==============================================================================