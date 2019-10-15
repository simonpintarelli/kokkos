KOKKOS_CFG_DEPENDS(TPLS OPTIONS)
KOKKOS_CFG_DEPENDS(TPLS DEVICES)

FUNCTION(KOKKOS_TPL_OPTION PKG DEFAULT)
  KOKKOS_ENABLE_OPTION(${PKG} ${DEFAULT} "Whether to enable the ${PKG} library")
  KOKKOS_OPTION(${PKG}_DIR "" PATH "Location of ${PKG} library")
  SET(KOKKOS_ENABLE_${PKG} ${KOKKOS_ENABLE_${PKG}} PARENT_SCOPE)
  SET(KOKKOS_${PKG}_DIR  ${KOKKOS_${PKG}_DIR} PARENT_SCOPE)
ENDFUNCTION()

IF(Trilinos_ENABLE_Kokkos AND TPL_ENABLE_QTHREAD)             
SET(QTHR_DEFAULT ON)
ELSE()
SET(QTHR_DEFAULT OFF)
ENDIF()
KOKKOS_TPL_OPTION(QTHREAD ${QTHR_DEFAULT} 
  "Whether to build Qthreads backend - may also require -DQTHREAD_DIR")

KOKKOS_TPL_OPTION(HWLOC   Off)
KOKKOS_TPL_OPTION(LIBNUMA Off)
KOKKOS_TPL_OPTION(MEMKIND Off)
KOKKOS_TPL_OPTION(CUDA    Off)
KOKKOS_TPL_OPTION(LIBRT   Off)
KOKKOS_TPL_OPTION(LIBDL   On)

IF(Trilinos_ENABLE_Kokkos AND TPL_ENABLE_HPX)
SET(HPX_DEFAULT ON)
ELSE()
SET(HPX_DEFAULT OFF)
ENDIF()
KOKKOS_TPL_OPTION(HPX ${HPX_DEFAULT})

IF(Trilinos_ENABLE_Kokkos AND TPL_ENABLE_PTHREAD)
SET(PTHREAD_DEFAULT ON)
ELSE()
SET(PTHREAD_DEFAULT OFF)
ENDIF()
KOKKOS_TPL_OPTION(PTHREAD ${PTHREAD_DEFAULT})

IF (KOKKOS_ENABLE_HPX)
  FIND_PACKAGE(HPX REQUIRED)
#  MESSAGE(STATUS "KOKKOS_ENABLE_HPX: ${HPX_DIR}")
ENDIF()

KOKKOS_IMPORT_TPL(HWLOC   Kokkos::hwloc)
KOKKOS_IMPORT_TPL(LIBNUMA Kokkos::libnuma)
KOKKOS_IMPORT_TPL(LIBRT   Kokkos::librt)
KOKKOS_IMPORT_TPL(LIBDL   Kokkos::libdl)
KOKKOS_IMPORT_TPL(MEMKIND Kokkos::memkind)
KOKKOS_IMPORT_TPL(PTHREAD Kokkos::pthread)

FIND_PACKAGE(TestHeaderOnly)
FIND_PACKAGE(TestLibraryOnly)
FIND_PACKAGE(TestCompileOnly)

