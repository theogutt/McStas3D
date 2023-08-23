include_guard()

#common place to define locations
option( MCCODE_USE_LEGACY_DESTINATIONS "Whether or not to install files to legacy (pre Nov 2022) locations" ON )

if ( NOT MCCODE_VERSION OR NOT FLAVOR )
  message(FATAL_ERROR "Locations module should only be invoked after FLAVOR and MCCODE_VERSION have been set" )
endif()

function( configure_destination_dirs resultvarname )
  set( provided_vars "")
  macro( destset varname content )
    list(APPEND provided_vars "${varname}" "${content}")
  endmacro()

  #NOTE: Please update mccode_config.json.in if adding new variables here!

  if ( MCCODE_USE_LEGACY_DESTINATIONS )
    message( "Choosing backwards compatible installation destinations (disable via MCCODE_USE_LEGACY_DESTINATIONS=OFF)" )
    set( dest_prefix "${FLAVOR}/${MCCODE_VERSION}" )
    destset( DEST_BINDIR "${dest_prefix}/bin" )
    destset( DEST_LIBDIR "${dest_prefix}/libs" )
    destset( DEST_DATADIR_TOPENVFILES "${dest_prefix}" )
    destset( DEST_DATADIR_INFO "${dest_prefix}" )
    destset( DEST_DATADIR_EDITORS "${dest_prefix}/editors" )
    destset( DEST_DATADIR_DOC "${dest_prefix}/doc" )
    destset( DEST_TOOLDIR "${dest_prefix}/tools" )
    destset( DEST_RESOURCEDIR "${dest_prefix}")
  else()
    include( GNUInstallDirs )
    destset( DEST_BINDIR "${CMAKE_INSTALL_BINDIR}")
    destset( DEST_LIBDIR "${CMAKE_INSTALL_LIBDIR}")
    destset( DEST_RESOURCEDIR "${CMAKE_INSTALL_DATADIR}/${FLAVOR}/resources")
    destset( DEST_DATADIR_TOPENVFILES "${CMAKE_INSTALL_DATADIR}/${FLAVOR}" )
    destset( DEST_DATADIR_INFO "${CMAKE_INSTALL_DATADIR}/${FLAVOR}/info" )
    destset( DEST_DATADIR_EDITORS "${CMAKE_INSTALL_DATADIR}/${FLAVOR}/editors" )
    destset( DEST_DATADIR_DOC "${CMAKE_INSTALL_DATADIR}/${FLAVOR}/doc" )
    destset( DEST_TOOLDIR "${CMAKE_INSTALL_DATADIR}/${FLAVOR}/tools" )
  endif()
  set(${resultvarname} "${provided_vars}" PARENT_SCOPE)
endfunction()

if ( MCCODE_USE_LEGACY_DESTINATIONS )
  set ( MCCODE_LEGACY_PATHS 1 )
else()
  set ( MCCODE_LEGACY_PATHS 0 )
endif()

function( apply_destination_dirs dir_list )
  while( dir_list )
    list( POP_FRONT dir_list varname varval)
    set(${varname} "${varval}" PARENT_SCOPE)
    message("McCode install destination: ${varname}=\"${varval}\"")
  endwhile()
endfunction()

configure_destination_dirs( tmp_detected_var_list )
apply_destination_dirs( "${tmp_detected_var_list}" )
unset( tmp_detected_var_list )

set( DEST_DATADIR_DATAFILES "${DEST_RESOURCEDIR}/data")
set( DEST_DATADIR_CODEFILES "${DEST_RESOURCEDIR}/share")
set( DEST_DATADIR_COMPS "${DEST_RESOURCEDIR}")
set( DEST_DATADIR_EXAMPLES "${DEST_RESOURCEDIR}/examples")
set( DEST_INTERNALPYDIR "${DEST_TOOLDIR}/Python" )


#Get a few relative paths, mostly for expansion in various installed files (we
#use PROJECT_BINARY_DIR as prefix here, but it should not matter which as long
#as it is an absolute path):

file(RELATIVE_PATH MCCODE_RELPATH_BINDIR2LIBDIR       "${PROJECT_BINARY_DIR}/${DEST_BINDIR}"  "${PROJECT_BINARY_DIR}/${DEST_LIBDIR}" )
file(RELATIVE_PATH MCCODE_RELPATH_BINDIR2RESOURCEDIR  "${PROJECT_BINARY_DIR}/${DEST_BINDIR}"  "${PROJECT_BINARY_DIR}/${DEST_RESOURCEDIR}" )
file(RELATIVE_PATH MCCODE_RELPATH_BINDIR2TOOLDIR      "${PROJECT_BINARY_DIR}/${DEST_BINDIR}"  "${PROJECT_BINARY_DIR}/${DEST_TOOLDIR}" )
file(RELATIVE_PATH MCCODE_RELPATH_TOOLDIR2BINDIR      "${PROJECT_BINARY_DIR}/${DEST_TOOLDIR}" "${PROJECT_BINARY_DIR}/${DEST_BINDIR}" )
file(RELATIVE_PATH MCCODE_RELPATH_TOOLDIR2LIBDIR      "${PROJECT_BINARY_DIR}/${DEST_TOOLDIR}" "${PROJECT_BINARY_DIR}/${DEST_LIBDIR}" )
file(RELATIVE_PATH MCCODE_RELPATH_TOOLDIR2RESOURCEDIR "${PROJECT_BINARY_DIR}/${DEST_TOOLDIR}" "${PROJECT_BINARY_DIR}/${DEST_RESOURCEDIR}" )

#Standard preamble for bash .in scripts (expanded from @MCCODE_BASH_STANDARD_PREAMBLE@):
include( Locations )
function( setup_standard_bash_preamble )
  set( lines
    "############################################"
    "# Start of standard CMake-generated preamble"
    "MCCODE_BINDIR=\"\$( cd -P \"\$( dirname \"\${BASH_SOURCE[0]}\" )\" && pwd )\""
    "MCCODE_TOOLDIR=\"\${MCCODE_BINDIR}/${MCCODE_RELPATH_BINDIR2TOOLDIR}\""
    "MCCODE_LIBDIR=\"\${MCCODE_BINDIR}/${MCCODE_RELPATH_BINDIR2LIBDIR}\""
    "MCCODE_RESOURCEDIR=\"\${MCCODE_BINDIR}/${MCCODE_RELPATH_BINDIR2RESOURCEDIR}\""
    "if [ -d \"\${MCCODE_TOOLDIR}\" ]; then"
    "    MCCODE_TOOLDIR=\"\$( cd -P \"\${MCCODE_TOOLDIR}\" && pwd )\""
    "else"
    "    MCCODE_TOOLDIR=\"\""
    "fi"
    "if [ -d \"\${MCCODE_LIBDIR}\" ]; then"
    "    MCCODE_LIBDIR=\"\$( cd -P \"\${MCCODE_LIBDIR}\" && pwd )\""
    "else"
    "    MCCODE_LIBDIR=\"\""
    "fi"
    "if [ -d \"\${MCCODE_RESOURCEDIR}\" ]; then"
    "    MCCODE_RESOURCEDIR=\"\$( cd -P \"\${MCCODE_RESOURCEDIR}\" && pwd )\""
    "else"
    "    MCCODE_RESOURCEDIR=\"\""
    "fi"
    "# End of standard preamble"
    "############################################"
    )
  string( JOIN "\n" tmp ${lines} )
  set( MCCODE_BASH_STANDARD_PREAMBLE "${tmp}" PARENT_SCOPE )
endfunction()
setup_standard_bash_preamble()
