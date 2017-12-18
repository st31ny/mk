Package-based Makefile System
=============================

The ADS build system is a set of GNU-make Makefiles intended for small to medium
projects consisting of multiple packages with many source files distributed in a
directory hierarchy. Packages can have dependencies on each other and produce a
binary or library. Additionally, static files for `make install` (configuration
files, bitmaps, ...) can be specified.

The template assumes that one or more source files are compiled to object files and
multiple object files are linked to form a binary. The individual steps of compiling
and linking can be adapted easily, i.e., the Makefile bundle can be extended for
more programming languages and target formats. This flexible design can even be
extended for multiple-step compilation as demonstrated for capnp files (these are
first compiled to C++ source files which are then compiled with g++).

Different sets of compilation and linker settings ("configurations") allow individual
configuration of debug and release targets. Furthermore, a special "test" build
is intended to easily run unit tests. The build system is completed by automatic
dependency management (i.e., source files depend on their header files), so a
simple `make` will update your build as necessary.

Usage
-----

Clone the repo into a subdirectory `mk` in your projects root directory (e.g.,
using git's submodule feature).
In your project structure, each directory with source files and all their parent
directories contain either a Makefile (for package root directories) or a dir.mk.

Create a `Makefile` in the project's root directory just like the Makefile.tmpl
template to make it a package. It contains variables describing the properties
of the package and, potentially, information that can also be found in "dir.mk"
files.

In order to keep distributed information distributed, directories with source files
can contain `dir.mk` files that extend the list of files to compile and install. As
your project might consist of several sub-projects (e.g., libraries), you can create
several packages, each consisting of a Makefile in its root directory and express
dependencies between them.

Additionally, file dependencies can be expressed, i.e., package targets depend on
their object files and Makefiles and object files depend on their source and header
files and Makefiles.

Files
-----

Place a file "Makefile" in every package's root directory, including the project's
top directory. Other directories can optionally contain files called `dir.mk`. As
in the templates (Makefile.tmpl, dir.mk.tmpl), all Makefile fragments contain a
definition of the variable `MYDIR` somewhere at the beginning which should look like
this:

    MYDIR                   := $(dir $(lastword $(MAKEFILE_LIST)))

`Makefile`s only contain an additional optional definition of `BUILDDIR`:

    BUILDIR                 ?= .

Both file types end with an `include` stanza for packages:

    include $(BUILDIR)/mk/pkg.mk

or for directories:

    include $(BUILDIR)/mk/dir.mk

For a description of all recognized variables see the [Variables](#variables)  section.

Configurations
--------------

The build system allows a way to express conditional compilation using configuration.
You can use arbitrary configuration names without explicitly declaring them, but two
names are created by default:

 * `main`: This is the default configuration assumed when you run `make` or `make all`.
 * `test`: This configuration is built when you run `make test` in order to compile
   a test target.

*TODO: more explanation*

Variables
---------

The entire ADS build system is based on make variables which describe compiler and
linker flags, files and directories to compile. Some variables affect the entire
build while others are set on a per-package or per-directory basis.

### Globals

The following variables affect an entire build process and are intended to be
overridden on the command line.

 * `BUILDDIR`: root directory of the build process, must contain the `mk` subdir
 * `BUILD`: active configuration (see below)
 * `DESTDIR`: target root directory for installing
 * Flags are set by defining them with a non-empty value (e.g., "1")
     * `MK_NOMAKEFILEDEP`: avoid generating dependencies on Makefiles (intended
       for developing the make system)

### Package Variables

*TODO*

### Local Variables

*TODO*
