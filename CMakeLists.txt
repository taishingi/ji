cmake_minimum_required(VERSION 3.25)

project(ji)

macro(add_lib name)
    add_library(${name} src/${name}.c headers/${name}.h)
    install(TARGETS ${name} DESTINATION lib)
    install(FILES headers/${name}.h DESTINATION include)
endmacro()

add_lib(nol)