project('xtensor-blas', 'cpp',
    version:'0.16.1',
    license:'BSD-3-Clause',
    default_options : ['warning_level=3', 'cpp_std=c++14'])

xtensor_blas_deps = [dependency('xtensor',
    version:'>=0.20.0',
    fallback : ['xtensor', 'xtensor_dep'] )]

# -Wno-parentheses because there are warnings about this is in just about every file in lapack
add_project_arguments('-Wno-parentheses', language : 'c')

xtensor_blas_cpp_arg = []

xtensor_blas_includes = [include_directories('include', is_system: true)]

# Okay, here's the incredibly confusing situation.

# xtensor-blas is an interface between xtensor and BLAS/LAPACK.  I suppose that's easy enough to understand.
# BLAS is a collection of low-level matrix and vector arithmetic operations.  Basic Linear Algebra Subprograms
# LAPACK is a collection of higher-level linear algebra operations.  Linear Algebra PACKage
# netlib houses a reference implementation of both; however their APIs have been used to create better performing libraries
# over the years.

# That seems easy enough.  You provide a blas implementation and a lapack implementation, and xtensor-blas knows how to 
# use it to increase performance of xtensor functions.  Most Linux distros have packages to install for these libraries,
# they are very popular.

# Ubuntu (our main build machine) has libraries for amd64, and also has libraries for cross-compiling armhf and arm64.
# We can cross-compile win64 because mingw-w64 will use the same libraries that we installed for amd64.
# What's missing is armel.

# If we don't have packages already, we can build the libraries.  The problem?
# They are both oringally written in Fortran.  We don't really want to add a Fortran compiler to our required build environment...
# And since we are building on many platforms, we don't want to provide a bunch of precompiled libraries.

# xtensor-blas comes with FLENS BLAS and FLENS LAPACK.  They are both C++.  They are both header-only.
# FLENS BLAS is supposed to be complete, but FLENS LAPACK doesn't include all the capabilities of the original LAPACK library.
# So to get all LAPACK functionality, a separate LAPACK library is necessary.

# From what I understand, BLAS can stand alone, but LAPACK depends upon BLAS.

# xtensor-blas suggests using OpenBLAS and shows how to set things up to link against it.
# BLAS C/C++ implementations:
# - FLENS BLAS does implement BLAS as well as act as an interface to an external library
# - CBLAS
# - OpenBLAS
# - BLIS (https://github.com/flame/blis) which sounds like it might be faster than OpenBLAS
# - ATLAS - is no longer state of the art

# xtensor-blas doesn't have any suggestions for LAPACK.
# There are many attempts at writing a C/C++ LAPACK library, but few have succeeded.
# - LAPACK++ stopped development in 2010, and doesn't include all the capabilities of the original LAPACK library.
# - IT++ stopped development in 2013, and doesn't include all the capabilities of the original LAPACK library.
# - MKL (Intel Math Kernel Library) works on Intel platforms only.
# - ACML (AMD Core Math Library) reached end of life and is no longer available.  Also has/had a restrictive license.
# - CLAPACK is a "Fortran to C" conversion project.  Last update 2009.  But I was able to compile it...  And it has cmake...
# - LAPACKE is a C interface to LAPACK
# - ATLAS - is no longer state of the art

# CLAPACK has its own CBLAS (looks like another "Fortran to C" conversion, probably from the original Fortran 77 BLAS)
# This CBLAS may not perform well.

# xtensor | xtensor-blas | FLENS BLAS by itself
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | CBLAS (that comes with CLAPACK)

# xtensor | xtensor-blas | FLENS BLAS with OpenBLAS 
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | CBLAS (that comes with CLAPACK)

# xtensor | xtensor-blas | FLENS BLAS with BLIS
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | CBLAS (that comes with CLAPACK)

#use_flens = true

# Let's try the easiest case first.  At least, I think this is the easiest case.
# xtensor | xtensor-blas | FLENS BLAS by itself
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | CBLAS (that comes with CLAPACK)
#
# We need to do the following:
# - Tell xtensor-blas to use FLENS LAPACK (as API).  (Will it automatically use CLAPACK's CBLAS since we link it in?)
# + Tell xtensor-blas to use FLENS BLAS implementation (not using external BLAS library)
# - Tell FLENS LAPACK to use CLAPACK
# - Let CLAPACK use its own CBLAS implementation

# Option:  LAPACK_LIB=CLAPACK
# Option:  BLAS_LIB=FLENS_BLAS

# Before attempting to build BLAS and LAPACK, see if they are installed on the system already.
system_installed_blas = dependency('blas', required : false)
system_installed_lapack = dependency('lapack', required : false)

# If they weren't found, meson will ignore these variables.  But we can use them for additional logic.
xtensor_blas_deps = [system_installed_blas, system_installed_lapack]

if not system_installed_blas.found()
    # If we can't find BLAS, we could fall back to FLENS BLAS.
    # TODO: This is not very optimal, and xtensor-blas recommends compiling OpenBLAS or some other implementation instead.
    # TODO:  Does using FLENS BLAS require compiling stuff in the include/xflens subfolder?
    xtensor_blas_cpp_arg += ['-DXTENSOR_USE_FLENS_BLAS']
endif

if not system_installed_lapack.found()
    # We still need a full LAPACK library, because FLENS LAPACK does not have everything that STK needs.
    cmake = import('cmake')
    # -Wno-dev suppresses warnings for clapack cmake project developers (not us)
    # -DCMAKE_POSITION_INDEPENDENT_CODE=True since we are creating libraries that will link into a greater shared library
    clapack_subproj = cmake.subproject('clapack', cmake_options : ['-Wno-dev', '-DCMAKE_POSITION_INDEPENDENT_CODE=True'])
       
    xtensor_blas_deps += [clapack_subproj.dependency('f2c'), clapack_subproj.dependency('blas'), clapack_subproj.dependency('lapack')]
endif


# Fedora specfically requires 'cblas' for reasons unknown
if (host_machine.system() == 'linux')
    os_name = run_command('head', '-1', '/etc/os-release').stdout().strip()
    if (os_name == 'NAME=Fedora')
        xtensor_blas_deps += [dependency('cblas')]
    endif
endif

xtensor_blas_dep = declare_dependency(include_directories: xtensor_blas_includes,
                                      dependencies: xtensor_blas_deps,
                                      compile_args: xtensor_blas_cpp_arg)


