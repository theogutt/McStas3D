# the name of the target operating system
SET(CMAKE_SYSTEM_NAME "Linux")
SET(ARCH   "arm64")

# Commands for running various external tools
set(BROWSER "xdg-open")
set(TERMINAL "x-terminal-emulator -e")
set(VRMLVIEW "whitedune")
set(TOOLS_CC "gcc")
set(MPICC "mpicc")
set(OACCFLAGS "-ta:tesla,managed -DOPENACC")
set(MPIRUN "mpirun")
set(PGPLOT "pgxwin_server")
set(GNUPLOT "gnuplot")

# Plotting options

set(PLOTTER "PGPLOT")
set(PGDEV "/xwin")
set(GNUDEV "wxt")

# Suffix for executables
set(EXE "out")

