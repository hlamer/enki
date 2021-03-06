: *****************************************************************
: build_installer.bat - Package the bundle into a Windows installer
: *****************************************************************
: This is the second phase of the `build system
: <build.html>`_. It packages a bundled executable version of the
: program, together with its source code, into a single
: installer.
:
: Gather files
: ------------
: First, this script gathers the following components needed
: to create a package, placing everything to be packaged
: into ``dist/all``:
:
: * ``src/``: Contains all Enki source code.
: * ``bin/``: Contains the Enki, Sphinx, and ctags binaries.
:
: **Note:** this should only by run after a successfull
: execution of ``build_exe.bat``, which
: creates the executables. Git should have all changes
: committed.
:
: This script makes use of several DOS commands with flags.
: A quick reference:
:
: For ``rmdir``:
:
: /S      Removes all directories and files in the specified
:         directory in addition to the directory itself.
:         Used to remove a directory tree.
: /Q      Quiet mode, do not ask if ok to remove a directory
:         tree with /S
:
: For ``xcopy``:
:
: /E      Copies directories and subdirectories,
:         including empty ones.
: /I      If destination does not exist and copying
:         more than one file, assumes that destination
:         must be a directory.
: /Q      Does not display file names while copying.
:
: Create a clean ``dist/all`` directory and enter it.
mkdir dist
cd dist
rmdir /q /s all
mkdir all
cd all
:
: Copy over the executables and supporting files which were generated by
: Pyinstaller.
xcopy /E /I /Q ..\enki bin
:
: Copy over the ctags executable.
copy ..\..\..\ctags58\ctags.exe bin
:
: Package
: -------
: The ``Enki.iss`` script then packages
: everything in ``dist/all`` into a single installer.
: Command-line options:
:
: /Q      Quiet compile (print error messages only)
"C:\Program Files (x86)\Inno Setup 5\ISCC.exe" /Q ..\..\win\Enki.iss
:
: Return to the directory this batch file was run from.
cd ..\..
