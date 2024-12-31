set(_l "${mumps_SOURCE_DIR}/libseq/")
if(given_openblas)
  if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL "IntelLLVM")
    foreach(i IN ITEMS elapse.h mpi.h mpic.c)
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/windows_intelLLVM/${i} DESTINATION ${_l})
    endforeach()
  endif()
endif()
add_library(mpiseq ${_l}elapse.c ${_l}mpi.f ${_l}mpic.c)
target_include_directories(mpiseq PUBLIC
"$<BUILD_INTERFACE:${_l}>"
$<INSTALL_INTERFACE:include>
)
set_property(TARGET mpiseq PROPERTY EXPORT_NAME MPISEQ)

install(TARGETS mpiseq EXPORT ${PROJECT_NAME}-targets)

install(FILES ${_l}elapse.h ${_l}mpi.h ${_l}mpif.h TYPE INCLUDE)
