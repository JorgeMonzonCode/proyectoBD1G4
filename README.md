# proyectoBD1G4

Proyecto académico del curso Bases de Datos 1 enfocado en el desarrollo de un sistema de Gestión Académica Universitaria utilizando Oracle Database 21c XE.

## Tecnologías utilizadas

- Oracle Database 21c XE
- Oracle SQL Developer
- Oracle SQL Developer Data Modeler 24.3
- SQL / PL-SQL
- Git y GitHub

## Estructura del repositorio

```text
proyectoBD1G4/

├── README.md
├── CONTRIBUTING.md
├── .gitignore

├── docs/
│   ├── 01_planificacion/
│   ├── 02_arquitectura/
│   ├── 03_concurrencia/
│   ├── 04_triggers_auditoria/
│   ├── 05_optimizacion/
│   ├── 06_metricas_graficas/
│   └── 07_presentacion/

├── model/
│   └── data_modeler/
│       └── gestion_academica_grupo4/
│           ├── ddl/
│           │   └── modelo_v01_generado.sql
│           └── exports/
│               └── modelo_relacional_v01.png

├── sql/
│   ├── 00_setup/
│   ├── 01_modelo/
│   ├── 02_datos_prueba/
│   ├── 03_transacciones/
│   ├── 04_concurrencia/
│   ├── 05_aq/
│   ├── 06_triggers/
│   ├── 07_indices/
│   ├── 08_optimizacion/
│   ├── 09_auditoria/
│   └── 10_pruebas_vivo/

├── scripts/
│   ├── carga_masiva/
│   └── multisesion/

├── evidencias/
│   ├── concurrencia/
│   ├── deadlocks/
│   ├── aq/
│   ├── triggers/
│   ├── planes/
│   ├── rendimiento/
│   └── auditoria/

├── individual/
│   ├── jorge/
│   ├── walter/
│   ├── daniel/
│   ├── isai/
│   └── okkan/

└── video/
    ├── guion/
    └── recursos/
```

Las carpetas pueden incluir archivos `.gitkeep` para que Git pueda conservarlas mientras estén vacías.

## Estado actual del proyecto

Actualmente se encuentra implementada y validada la base inicial del sistema de Gestión Académica Universitaria.

### Componentes implementados

- Modelo relacional base con 10 tablas.
- Tablespace `ACADEMICO_DATA`.
- Esquema propietario `ACADEMICO_G4`.
- Usuario de consulta `USR_CONSULTA_G4`.
- Usuario transaccional `USR_TRANSACCION_G4`.
- Permisos aplicando principio de mínimo privilegio.
- Datos mínimos de prueba.
- Flujo normal de inscripción.
- Uso de `COMMIT`.
- Uso de `SAVEPOINT`.
- Uso de `ROLLBACK TO SAVEPOINT`.
- Script para restaurar el escenario de pruebas.
- Evidencias de creación de tablas y restricciones.
- Evidencias de permisos para usuarios de consulta y transacción.

## Orden de ejecución inicial

Los scripts deben ejecutarse en el siguiente orden:

1. `sql/00_setup/001_tablespace.sql`
   - Ejecutar como usuario con rol DBA.
   - En el ambiente de desarrollo se utiliza `MONZON`.

2. `sql/00_setup/002_schema.sql`
   - Ejecutar como usuario con rol DBA.

3. `sql/00_setup/003_usuarios.sql`
   - Ejecutar como usuario con rol DBA.

4. `model/data_modeler/gestion_academica_grupo4/ddl/modelo_v01_generado.sql`
   - Ejecutar como `ACADEMICO_G4`.

5. `sql/00_setup/004_permisos.sql`
   - Ejecutar como `ACADEMICO_G4`.

6. `sql/02_datos_prueba/020_datos_minimos.sql`
   - Ejecutar como `ACADEMICO_G4`.

## Usuarios del proyecto

### `ACADEMICO_G4`

Usuario propietario del esquema principal.

Responsabilidades:

- Crear y administrar los objetos del modelo.
- Ejecutar el DDL del proyecto.
- Otorgar permisos sobre sus objetos.

### `USR_CONSULTA_G4`

Usuario destinado a consultas.

Permisos principales:

- `SELECT` sobre las tablas del sistema.
- No puede insertar, modificar ni eliminar información.

### `USR_TRANSACCION_G4`

Usuario utilizado para las operaciones relacionadas con el proceso de inscripción.

Permisos principales:

- `SELECT` sobre las tablas necesarias.
- `INSERT`, `UPDATE` y `DELETE` sobre `SOLICITUD_INSCRIPCION`.
- `INSERT`, `UPDATE` y `DELETE` sobre `INSCRIPCION`.
- `UPDATE` sobre `SECCION`.
- No puede modificar tablas administrativas como `CARRERA`.

Los permisos se asignan aplicando el principio de mínimo privilegio.

## Pruebas transaccionales

Los siguientes scripts se ejecutan como `USR_TRANSACCION_G4`:

- `sql/03_transacciones/030_inscripcion_normal.sql`
- `sql/03_transacciones/031_inscripcion_con_savepoint.sql`
- `sql/03_transacciones/032_rollback_parcial.sql`

### Inscripción normal

`030_inscripcion_normal.sql` demuestra una transacción completa de inscripción:

1. Registro de solicitud.
2. Creación de inscripción.
3. Reducción del cupo disponible.
4. Actualización de la solicitud.
5. Confirmación mediante `COMMIT`.

### SAVEPOINT

`031_inscripcion_con_savepoint.sql` demuestra la creación de un punto intermedio dentro de una transacción mediante:

```sql
SAVEPOINT SP_SOLICITUD_CREADA;
```

La operación continúa normalmente hasta finalizar con `COMMIT`.

### ROLLBACK parcial

`032_rollback_parcial.sql` demuestra el uso de:

```sql
ROLLBACK TO SP_SOLICITUD_CREADA;
```

Las operaciones realizadas después del `SAVEPOINT` son revertidas, mientras que las operaciones realizadas antes del punto de guardado permanecen.

## Restauración del escenario de pruebas

Antes de repetir una prueba de inscripción se debe ejecutar:

`sql/02_datos_prueba/021_reset_escenario_inscripcion.sql`

Este script se ejecuta como `USR_TRANSACCION_G4`.

El resultado esperado es:

- `TOTAL_INSCRIPCIONES = 0`
- `TOTAL_SOLICITUDES = 0`
- `CUPO_DISPONIBLE = 1`
- `ESTADO = ABIERTA`

Este script debe utilizarse únicamente en el ambiente de pruebas.

## Escenario mínimo de pruebas

El escenario actual incluye:

- 1 carrera.
- 2 estudiantes.
- 1 docente.
- 1 curso.
- 1 período académico.
- 1 sección.
- 1 horario.

La sección de prueba posee:

- `CUPO_MAXIMO = 1`
- `CUPO_DISPONIBLE = 1`
- `ESTADO = ABIERTA`

Este escenario permitirá posteriormente realizar pruebas de concurrencia donde dos estudiantes compitan por el último cupo disponible.

## Próximas etapas

El proyecto continuará con:

- Concurrencia y bloqueo de sesiones.
- Simulación de deadlocks.
- Oracle Advanced Queuing.
- Compound Triggers.
- Auditoría y Fine-Grained Auditing.
- Índices y optimización.
- Carga masiva de estudiantes.
- Análisis de planes de ejecución.
- Métricas y pruebas de rendimiento.