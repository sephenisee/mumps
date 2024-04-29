option(${PROJECT_NAME}_BUILD_TESTING "Build tests" ${PROJECT_IS_TOP_LEVEL})

option(given_scalapack "Use provided Scalapack")

option(find_static "Find static libraries for Lapack and Scalapack (default shared then static search)")

if(MUMPS_UPSTREAM_VERSION VERSION_GREATER_EQUAL 5.2)
  option(gemmt "GEMMT is recommended in User Manual if available" ON)
endif()

option(parallel "parallel (use MPI)" ON)

option(intsize64 "use 64-bit integers in C and Fortran" OFF)

option(scotch "use Scotch orderings" OFF)

option(parmetis "use parallel METIS ordering" OFF)
option(metis "use sequential METIS ordering" OFF)
if(parmetis AND NOT parallel)
  message(FATAL_ERROR "parmetis requires parallel=on")
endif()

option(openmp "use OpenMP" OFF)

option(matlab "Matlab interface" OFF)
if(matlab AND parallel)
  message(FATAL_ERROR "Matlab requires parallel=off")
endif()

option(find "find [SCA]LAPACK" OFF)

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

include(CheckPIESupported)
check_pie_supported()
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

option(BUILD_SINGLE "Build single precision float32 real" ON)
option(BUILD_DOUBLE "Build double precision float64 real" ON)
option(BUILD_COMPLEX "Build single precision complex" OFF)
option(BUILD_COMPLEX16 "Build double precision complex" OFF)

# --- other options

option(CMAKE_TLS_VERIFY "Verify TLS certificates" ON)

set_property(DIRECTORY PROPERTY EP_UPDATE_DISCONNECTED true)

set(FETCHCONTENT_UPDATES_DISCONNECTED true)

if(CMAKE_VERSION VERSION_LESS 3.21)
  get_property(_not_top DIRECTORY PROPERTY PARENT_DIRECTORY)
  if(NOT _not_top)
    set(PROJECT_IS_TOP_LEVEL true)
  endif()
endif()

if(PROJECT_IS_TOP_LEVEL AND CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set_property(CACHE CMAKE_INSTALL_PREFIX PROPERTY VALUE "${PROJECT_BINARY_DIR}/local")
endif()
