# Guía de contribución

Este documento define las reglas básicas para mantener organizado el desarrollo del proyecto de Gestión Académica Universitaria.

## Organización de archivos

- Coloca la documentación en `docs/`, según la etapa correspondiente.
- Coloca los scripts SQL en `sql/`, según el módulo al que pertenezcan.
- Guarda el modelo de Oracle SQL Developer Data Modeler en `model/data_modeler/`.
- Guarda los scripts de carga masiva y ejecución de múltiples sesiones en `scripts/`.
- Agrega las evidencias de las pruebas en la carpeta correspondiente de `evidencias/`.
- Usa tu carpeta dentro de `individual/` para guardar tus aportes y evidencias individuales.
- Guarda el guion y los recursos utilizados para la presentación en `video/`.
- Utiliza nombres descriptivos para archivos y scripts.
- No incluyas contraseñas, credenciales ni archivos de configuración que contengan información sensible.

## Flujo de ramas

El repositorio utiliza las siguientes ramas principales:

- `main`: versión estable y final del proyecto.
- `develop`: rama de integración.
- `feature/*`: ramas de desarrollo de nuevas funcionalidades.

Todo desarrollo debe realizarse en una rama `feature/*` y posteriormente integrarse a `develop` mediante Pull Request.

No se deben realizar cambios funcionales directamente sobre `main`.

## Flujo recomendado de trabajo

1. Cambiar a la rama `develop`.
2. Actualizarla con los últimos cambios.
3. Crear una nueva rama `feature/*`.
4. Realizar el desarrollo correspondiente.
5. Ejecutar las pruebas necesarias.
6. Crear commits descriptivos.
7. Hacer push de la rama.
8. Crear un Pull Request hacia `develop`.
9. Revisar los cambios.
10. Realizar el merge cuando las pruebas sean satisfactorias.

Ejemplo:

```bash
git checkout develop
git pull

git checkout -b feature/nueva-funcionalidad
```

## Pull Requests

Los Pull Requests de nuevas funcionalidades deben dirigirse a:

```text
develop
```

La rama `main` se utilizará para versiones estables o entregas finales.

Antes de crear un Pull Request se debe verificar que:

- Los scripts ejecuten correctamente.
- No existan errores conocidos.
- No se incluyan credenciales sensibles.
- Las evidencias correspondientes estén guardadas.
- Los scripts indiquen el usuario con el que deben ejecutarse.
- Las precondiciones estén documentadas cuando sea necesario.
- El `README.md` se actualice si cambia el flujo de instalación o ejecución.

## Convención de commits

Los mensajes de commit deben ser claros y descriptivos.

Se recomienda utilizar los siguientes prefijos:

- `feat:` nueva funcionalidad.
- `fix:` corrección de errores.
- `docs:` cambios de documentación.
- `test:` incorporación o actualización de pruebas.
- `perf:` mejoras de rendimiento.
- `refactor:` reorganización de código sin cambiar su funcionalidad.

Ejemplos:

```text
feat: agrega flujo de inscripcion y control transaccional
```

```text
docs: actualiza instrucciones de ejecucion del proyecto
```

```text
test: agrega evidencia de rollback parcial
```

## Scripts SQL

Los scripts deben incluir, cuando corresponda, un encabezado que indique:

- Nombre del archivo.
- Responsable.
- Objetivo.
- Usuario con el que debe ejecutarse.
- Esquema esperado.
- Precondiciones.
- Dependencias.
- Resultado esperado.
- Script o paso siguiente.

Ejemplo:

```sql
--==============================================================================
-- ARCHIVO        : ejemplo.sql
-- RESPONSABLE    : Nombre
-- OBJETIVO       : Describir el propósito del script.
--
-- EJECUTAR COMO  : USUARIO
--
-- PRECONDICIONES :
--   1. Condición previa.
--
-- RESULTADO ESPERADO:
--   - Resultado esperado.
--==============================================================================
```

## Scripts generados por Data Modeler

El DDL generado mediante Oracle SQL Developer Data Modeler debe mantenerse sincronizado con el modelo fuente.

No se recomienda modificar manualmente el DDL generado sin actualizar también el modelo correspondiente en Data Modeler.

El archivo actual del modelo base se encuentra en:

```text
model/data_modeler/gestion_academica_grupo4/ddl/modelo_v01_generado.sql
```

## Evidencias

Las evidencias deben permitir demostrar que la funcionalidad fue ejecutada correctamente.

Cuando aplique, deben mostrar:

- Usuario utilizado.
- Script ejecutado.
- Resultado obtenido.
- Errores esperados en pruebas negativas.
- Estado antes y después de una operación.

Las pruebas individuales deben guardarse dentro de:

```text
individual/<nombre>/
```

Las evidencias generales del proyecto deben guardarse en:

```text
evidencias/
```

## Buenas prácticas

- Mantener los scripts pequeños y enfocados en una función específica.
- Evitar duplicar código innecesariamente.
- Documentar operaciones que puedan modificar datos.
- Utilizar scripts de restauración para repetir pruebas.
- No realizar pruebas destructivas sin conocer su efecto.
- Confirmar la conexión y el usuario antes de ejecutar scripts administrativos o transaccionales.