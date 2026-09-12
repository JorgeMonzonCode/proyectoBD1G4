cmake_minimum_required(VERSION 3.16)

project(proyectoBD1G4 LANGUAGES CXX)

add_executable(proyectoBD1G4
    src/main.cpp
)

target_compile_features(proyectoBD1G4 PRIVATE cxx_std_17)
set_target_properties(proyectoBD1G4 PROPERTIES CXX_EXTENSIONS OFF)
target_include_directories(proyectoBD1G4 PRIVATE include)

if(MSVC)
    target_compile_options(proyectoBD1G4 PRIVATE /W4)
else()
    target_compile_options(proyectoBD1G4 PRIVATE -Wall -Wextra -Wpedantic)
endif()
