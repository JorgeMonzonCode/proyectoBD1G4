--==============================================================================
-- PROYECTO BASES DE DATOS 1 - GRUPO 4
-- GESTION ACADEMICA UNIVERSITARIA
--==============================================================================
-- ARCHIVO        : 020_datos_minimos.sql
-- RESPONSABLE    : Jorge
-- OBJETIVO       : Insertar los datos mínimos necesarios para validar
--                  relaciones y preparar las pruebas transaccionales.
--
-- EJECUTAR COMO  : Usuario propietario del esquema.
--                  Usuario: ACADEMICO_G4
--
-- ESQUEMA ACTUAL : ACADEMICO_G4
--
-- PRECONDICIONES :
--   1. Debe existir el esquema ACADEMICO_G4.
--   2. Deben existir las 10 tablas del modelo base.
--   3. Las tablas utilizadas deben estar vacías o no contener
--      los identificadores utilizados en este script.
--
-- DEPENDENCIAS   :
--   modelo_v01_generado.sql
--   sql/00_setup/004_permisos.sql
--
-- RESULTADO ESPERADO:
--   - 1 carrera creada.
--   - 2 estudiantes creados.
--   - 1 docente creado.
--   - 1 curso creado.
--   - 1 periodo académico creado.
--   - 1 sección creada.
--   - 1 horario creado.
--
-- NOTA:
--   La sección se crea con CUPO_MAXIMO = 1 y CUPO_DISPONIBLE = 1
--   para utilizarla posteriormente en pruebas de concurrencia,
--   donde dos estudiantes competirán por el último cupo.
--
--   Las tablas SOLICITUD_INSCRIPCION, INSCRIPCION y
--   AUDITORIA_INSCRIPCION se dejan vacías intencionalmente.
--==============================================================================


--==============================================================================
-- 1. CARRERA
--==============================================================================

INSERT INTO CARRERA
(
    ID_CARRERA,
    CODIGO_CARRERA,
    NOMBRE,
    ESTADO
)
VALUES
(
    1,
    'SIS',
    'INGENIERIA EN SISTEMAS',
    'ACTIVA'
);


--==============================================================================
-- 2. ESTUDIANTES
--==============================================================================

INSERT INTO ESTUDIANTE
(
    ID_ESTUDIANTE,
    CARNET,
    NOMBRE,
    APELLIDO,
    EMAIL,
    ID_CARRERA,
    ESTADO
)
VALUES
(
    1,
    '20260001',
    'CARLOS',
    'LOPEZ',
    'carlos.lopez@universidad.edu',
    1,
    'ACTIVO'
);

INSERT INTO ESTUDIANTE
(
    ID_ESTUDIANTE,
    CARNET,
    NOMBRE,
    APELLIDO,
    EMAIL,
    ID_CARRERA,
    ESTADO
)
VALUES
(
    2,
    '20260002',
    'MARIA',
    'GARCIA',
    'maria.garcia@universidad.edu',
    1,
    'ACTIVO'
);


--==============================================================================
-- 3. DOCENTE
--==============================================================================

INSERT INTO DOCENTE
(
    ID_DOCENTE,
    CODIGO_DOCENTE,
    NOMBRE,
    APELLIDO,
    EMAIL,
    ESTADO
)
VALUES
(
    1,
    'DOC001',
    'JUAN',
    'PEREZ',
    'juan.perez@universidad.edu',
    'ACTIVO'
);


--==============================================================================
-- 4. CURSO
--==============================================================================

INSERT INTO CURSO
(
    ID_CURSO,
    CODIGO_CURSO,
    NOMBRE_CURSO,
    CREDITOS,
    ESTADO
)
VALUES
(
    1,
    'BD1',
    'BASES DE DATOS 1',
    5,
    'ACTIVO'
);


--==============================================================================
-- 5. PERIODO ACADEMICO
--==============================================================================

INSERT INTO PERIODO_ACADEMICO
(
    ID_PERIODO,
    ANIO,
    CICLO,
    FECHA_INICIO,
    FECHA_FIN,
    ESTADO
)
VALUES
(
    1,
    2026,
    2,
    DATE '2026-07-01',
    DATE '2026-11-30',
    'ACTIVO'
);


--==============================================================================
-- 6. SECCION
--==============================================================================

INSERT INTO SECCION
(
    ID_SECCION,
    ID_CURSO,
    ID_DOCENTE,
    ID_PERIODO,
    CODIGO_SECCION,
    CUPO_MAXIMO,
    CUPO_DISPONIBLE,
    ESTADO
)
VALUES
(
    1,
    1,
    1,
    1,
    'A',
    1,
    1,
    'ABIERTA'
);


--==============================================================================
-- 7. HORARIO
--==============================================================================

INSERT INTO HORARIO
(
    ID_HORARIO,
    ID_SECCION,
    DIA_SEMANA,
    HORA_INICIO,
    HORA_FIN,
    AULA
)
VALUES
(
    1,
    1,
    'SABADO',
    '08:00',
    '10:00',
    'AULA-101'
);


--==============================================================================
-- 8. CONFIRMAR CAMBIOS
--==============================================================================

COMMIT;


--==============================================================================
-- 9. VALIDAR DATOS INSERTADOS
--==============================================================================

SELECT *
FROM CARRERA;

SELECT *
FROM ESTUDIANTE
ORDER BY ID_ESTUDIANTE;

SELECT *
FROM DOCENTE;

SELECT *
FROM CURSO;

SELECT *
FROM PERIODO_ACADEMICO;

SELECT *
FROM SECCION;

SELECT *
FROM HORARIO;