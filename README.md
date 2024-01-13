*******************************************************************************

```
 McStas, neutron ray-tracing code generator
         Copyright 1997-, All rights reserved
         Technical University of Denmark, Kongens Lyngby, Denmark
         Institut Laue Langevin, Grenoble, France
         European Spallation Source, Lund Sweden

 McXtrace, X-ray ray-tracing code generator
         Copyright 2009-, All rights reserved
         Technical University of Denmark, Kongens Lyngby, Denmark
         Synchrotron SOLEIL, Paris-Saclay, France

 Documentation: README

This file is part of McStas / McXtrace.
```
* <a href="http://www.mcstas.org">Official McStas website</a>
* <a href="http://www.mcxtrace.org">Official McXtrace website</a>

[![mcstas-basictest](https://github.com/McStasMcXtrace/McCode/actions/workflows/mcstas-basictest.yml/badge.svg)](https://github.com/McStasMcXtrace/McCode/actions/workflows/mcstas-basictest.yml)[![mcxtrace-basictest](https://github.com/McStasMcXtrace/McCode/actions/workflows/mcxtrace-basictest.yml/badge.svg)](https://github.com/McStasMcXtrace/McCode/actions/workflows/mcxtrace-basictest.yml)

*******************************************************************************
```
This is McStas 3.x and McXtrace 3.x with GPU acceleration support

Copyright (C) 1997-. All rights reserved. See the file COPYING for conditions on use.

This software is covered by the GNU General Public License. User instrument
files generated by McStas/McXtrace, output data or papers based on these use
is NOT considered "derived work" but is considered normal usage of the software.

If a certain file is NOT licensed under GPL, this will be reflected by a
file header or local LICENSE file.

The random number algorithm used is a newly in-house "KISS" algorithm developed
at a GPU Hackathon in Espoo Finland with the help of NVIDIA mentor Christian Hundt.

If you wish to use McStas/McXtrace in ways that contradict the conditions,
contact us and chances are that we will be able to make a suitable
arrangement.

Installation instructions are in the doc/install_docs directory.

Changes from previous versions are in the file CHANGES. Please read that !

To get started, some example instrument definitions have been supplied
in the mcstas-comps/examples/ and mcxtrace-comps/examples directories.
To run a simulation, the command `mcrun' (or mxrun) is used. For example:

    mcrun ISIS_Prisma2.instr -n2e6 TT=-30 PHA=22 PHA1=-3 PHA2=-2 PHA3=-1 PHA4=0 PHA5=1 PHA6=2 PHA7=3 TTA=44

This will first compile the instrument definition (if necessary) and
subsequently run it. It is also possible to run simulations from the
graphical user interface `mcgui' (or mxgui), or to compile and run
simulations manually.

The output files will be put in the current directory by default. The
file tas1-scans in the example directory is a script that will run a
series of simulations that constitute a line-up experiment of the TAS1
spectrometer at Risoe.

To fully utilize McStas/McXtrace, you will need a copy of the manual. It
may be found in the lib/doc directory of the distribution.

The manual, along with much other information, is
available from the McStas WWW home page:

    http://www.mcstas.org

or in the case of McXtrace:

   http://www.mcxtrace.org

User mailinglists:
  mcstas-users@mcstas.org
  mcxtrace-users@mcxtrace.org

Feel free to direct any comments or questions to these mailinglist addresses.
It is an important goal of the McStas and McXtrace projects to have
the programs widely used, so if you have a reasonable request there is a good
chance that we will be willing to help you out.

Contacts for McStas are:
  Peter Kjaer Willendrup <pkwi@dtu.dk>/<peter.willendrup@ess.eu> (PW)
  Emmanuel Farhi <emmanuel.farhi@synchrotron-soleil.fr> (EF)
  Mads Bertelsen <mads.bertelsen@ess.eu) (MB)
  Kim Lefmann <lefmann@nbi.dk> (KL)

Contacts for McXtrace are:
  Peter Kjaer Willendrup <pkwi@fysik.dtu.dk> (PW)
  Emmanuel Farhi <emmanuel.farhi@synchrotron-soleil.fr> (EF)

Previous authors are:
  Kristian Nielsen, email (KN)
  Per-Olof AAstrand (PEO)
  Klaus Lieutenant (KL2)
  Peter Christiansen (PC)
  Erik Knudsen (EK)

Some parts of McStas/McXtrace require additional software to be installed in
order to work. The needed software packages are either included as part of
your installation bundle (Windows/macOS) or come as dependencies of the
installation packages (Linux)

 - The 'mcstas/mcxtrace' base programs only requires a C compiler, which is usually
   provided with most Unix/Linux systems. For Windows, a MinGW C compiler
   is shipped with Strawberry-Perl which is distributed alongside the installers.
 - The `mcrun/mxrun' front-ends require Perl or python
 - The `mcdisplay/mxdisplay' front-ends requires Perl or python plus graphical
   backend(s)
 - The `mcplot/mxplot' front-ends requires Perl or python plus graphical
   backend(s) 
 - The `mcgui/mxgui' graphical user interface requires python, PyQt and optionally
   qscintilla for the built in instrument editor. Alternatively an external editor
   can be used, we recommend gedit.

```