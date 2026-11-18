cmake_minimum_required(VERSION 3.16)
project(Tank C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(SDL3 REQUIRED CONFIG)

add_executable(tank src/tank.c)
target_link_libraries(tank PRIVATE SDL3::SDL3)

if(MSVC)
    target_compile_options(tank PRIVATE /W4)
else()
    target_compile_options(tank PRIVATE -Wall -Wextra)
endif()

# The game loads its two PCX images from an assets folder next to the binary
add_custom_command(TARGET tank POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${CMAKE_SOURCE_DIR}/assets $<TARGET_FILE_DIR:tank>/assets)
