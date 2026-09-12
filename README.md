# proyectoBD1G4
Proyecto de curso bases de datos 1

## Base del proyecto

Proyecto en C++17, sin dependencias externas.

```text
proyectoBD1G4/
├── CMakeLists.txt    # Configuración de compilación
├── include/          # Encabezados (.h o .hpp)
├── src/              # Implementaciones (.cpp)
│   └── main.cpp      # Punto de entrada
├── .gitignore
└── README.md
```

## Compilar y ejecutar con CMake

Requiere CMake 3.16 o posterior y un compilador compatible con C++17.
Ejecuta desde la raíz del proyecto:

```sh
cmake -S . -B build
cmake --build build
./build/proyectoBD1G4
```

Con generadores de varias configuraciones, como Visual Studio, el ejecutable
puede quedar en `build/Debug/proyectoBD1G4.exe`.

## Compilar sin CMake (macOS o Linux)

```sh
mkdir -p build
clang++ -std=c++17 -Wall -Wextra -Wpedantic -Iinclude src/main.cpp -o build/proyectoBD1G4
./build/proyectoBD1G4
```

También puedes usar `g++` en lugar de `clang++`.

## Agregar código

- Guarda las implementaciones en `src/` y los encabezados en `include/`.
- Agrega cada nuevo `.cpp` a la lista de `add_executable` en `CMakeLists.txt`.
- Si compilas sin CMake, incluye los nuevos `.cpp` en el comando del compilador.
- La organización en módulos se definirá cuando estén disponibles los requisitos.
