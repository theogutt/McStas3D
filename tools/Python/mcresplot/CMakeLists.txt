cmake_minimum_required(VERSION 2.6)

# This will install McStas mcresplot
project(python-tools-mcresplot)

# Set module path
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# Set McCode values (from mkdist or defaults)
include(MCUtil)

set(FLAVOR "mcstas")
setupMCCODE("${FLAVOR}")

# Select prefix
set(P "${MCCODE_PREFIX}")

set(TOOLS_NAME "tools/Python/mcresplot")

# CPack configuration
set(CPACK_PACKAGE_NAME          "${FLAVOR}-tools-python-mcresplot-${MCCODE_VERSION}")
set(CPACK_RESOURCE_FilE_LICENSE "${PROJECT_SOURCE_DIR}/../../COPYING")
set(CPACK_PACKAGE_CONTACT       "pkwi@fysik.dtu.dk")

set(CPACK_PACKAGE_VERSION       "1.0")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")


# NSIS
set(NSIS_NAME "Python-based mcresplot, ${MCCODE_STRING}")
set(CPACK_NSIS_PACKAGE_NAME "${NSIS_NAME}")
set(CPACK_NSIS_DISPLAY_NAME "${NSIS_NAME}")

# Debian
set(CPACK_DEBIAN_PACKAGE_DEPENDS "${FLAVOR}-${MCCODE_VERSION}, python3-matplotlib, python3-numpy")

# RPM
set(CPACK_RPM_PACKAGE_REQUIRES
  "${FLAVOR}-${MCCODE_VERSION}, ${FLAVOR}-miniconda3-${MCCODE_VERSION}"
  )


include(CPack)

set(WORK "${PROJECT_BINARY_DIR}/work")

# Program files
if(WINDOWS)
  set(TOOLS_LIB "${CMAKE_INSTALL_PREFIX}/${lib}/${FLAVOR}/${MCCODE_VERSION}/${TOOLS_NAME}")
else()
  set(TOOLS_LIB "${CMAKE_INSTALL_PREFIX}/${FLAVOR}/${MCCODE_VERSION}/${TOOLS_NAME}")
endif()

# Configure fallback script
configure_file("${CMAKE_SOURCE_DIR}/mcresplot.in" "${WORK}/mcresplot" @ONLY)

if(WINDOWS)
  install(
    FILES "${PROJECT_SOURCE_DIR}/mcresplot.py"
    DESTINATION "${lib}/${TOOLS_NAME}"
    PERMISSIONS
    OWNER_READ OWNER_WRITE OWNER_EXECUTE
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE
  )

  foreach(NAME "cov.py" "tas.py")
    install(
      FILES "${PROJECT_SOURCE_DIR}/${NAME}"
      DESTINATION "${lib}/${TOOLS_NAME}"
      )
  endforeach()
endif()

if(NOT WINDOWS)
  foreach(NAME "mcresplot.py" "cov.py" "tas.py")
    install(
      FILES "${PROJECT_SOURCE_DIR}/${NAME}"
      DESTINATION "${FLAVOR}/${MCCODE_VERSION}/${TOOLS_NAME}"
      )
  endforeach()
  
  add_custom_target(
    "CREATE_SYMLINK" ALL DEPENDS "${WORK}/mcresplot"
    )

  install(
    FILES "${WORK}/mcresplot"
    DESTINATION "${FLAVOR}/${MCCODE_VERSION}/${TOOLS_NAME}"
    PERMISSIONS
    OWNER_READ OWNER_WRITE OWNER_EXECUTE
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE
  )
  install(
    FILES "${PROJECT_SOURCE_DIR}/mcresplot.py"
    DESTINATION "${FLAVOR}/${MCCODE_VERSION}/${TOOLS_NAME}"
    RENAME "mcresplot.py"
    PERMISSIONS
    OWNER_READ OWNER_WRITE OWNER_EXECUTE
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE
  )

  
  install(
    PROGRAMS "${WORK}/mcresplot"
    DESTINATION ${FLAVOR}/${MCCODE_VERSION}/bin
    )
endif()