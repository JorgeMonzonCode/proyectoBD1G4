--==============================================================================
-- VALIDACION DEL MODELO BASE
-- EJECUTAR COMO: ACADEMICO_G4
--==============================================================================

-- 1. VALIDAR CANTIDAD TOTAL DE TABLAS
SELECT COUNT(*) AS TOTAL_TABLAS
FROM user_tables;


-- 2. LISTAR TABLAS CREADAS
SELECT table_name
FROM user_tables
ORDER BY table_name;


-- 3. VALIDAR TIPOS DE RESTRICCIONES
SELECT constraint_type,
       COUNT(*) AS TOTAL
FROM user_constraints
WHERE table_name IN (
    'AUDITORIA_INSCRIPCION',
    'CARRERA',
    'CURSO',
    'DOCENTE',
    'ESTUDIANTE',
    'HORARIO',
    'INSCRIPCION',
    'PERIODO_ACADEMICO',
    'SECCION',
    'SOLICITUD_INSCRIPCION'
)
GROUP BY constraint_type
ORDER BY constraint_type;