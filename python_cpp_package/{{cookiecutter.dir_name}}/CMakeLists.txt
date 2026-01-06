cmake_minimum_required(VERSION 3.15...4.0)

project(
    ${SKBUILD_PROJECT_NAME}
    VERSION ${SKBUILD_PROJECT_VERSION}
    LANGUAGES CXX
)

set(PYBIND11_FINDPYTHON ON)
find_package(pybind11 CONFIG REQUIRED)

# Add include directories if needed
# include_directories(include ${CMAKE_SOURCE_DIR}/external)

pybind11_add_module(_{{cookiecutter.project_slug}} src/main.cpp)

install(TARGETS _{{cookiecutter.project_slug}} DESTINATION .)
