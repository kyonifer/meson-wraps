project('xtensor-blas', 'cpp',
    version:'0.16.1',
    license:'BSD-3-Clause',
    default_options : ['warning_level=3', 'cpp_std=c++14'])

xtensor_blas_deps = [dependency('xtensor',
    version:'>=0.20.0',
    fallback : ['xtensor', 'xtensor_dep'] )]

xtensor_blas_cpp_arg = []

xtensor_includes = [include_directories('include', is_system: true)]

# TODO:  If we can't find openblas (or lapack?), we could fall back to FLENS.
# Which requires compiling stuff in the include/xflens subfolder?

# Okay, here's the incredibly confusing situation.

# xtensor-blas is an interface between xtensor and BLAS/LAPACK.  I suppose that's easy enough to understand.
# BLAS is a collection of low-level matrix and vector arithmetic operations.  Basic Linear Algebra Subprograms
# LAPACK is a collection of higher-level linear algebra operations.  Linear Algebra PACKage
# netlib houses a reference implementation of both; however their APIs have been used to create better performing libraries
# over the years.

# That seems easy enough.  You provide a blas implementation and a lapack implementation, and xtensor-blas knows how to 
# use it to increase performance of xtensor functions.

# So, what's the hard part about providing a blas implementation?  Or a lapack implementation?
# They are both oringally written in Fortran.  We don't really want to add a Fortran compiler to our required build environment...
# And since we are building on many platforms, we don't want to provide a bunch of precompiled libraries.

# xtensor-blas suggests using OpenBLAS and shows how to set things up to link against it.
# But it doesn't have any suggestions for LAPACK.
# BLAS C/C++ implementations:
# - FLENS BLAS does implement BLAS as well as act as an interface to an external library
# - CBLAS
# - OpenBLAS
# - BLIS (https://github.com/flame/blis) which sounds like it might be faster than OpenBLAS

# From what I understand, BLAS can stand alone, but LAPACK depends upon BLAS.

# xtensor-blas comes with FLENS BLAS and FLENS LAPACK.  They are both C++.  They are both header-only.
# FLENS BLAS is supposed to be complete, but FLENS LAPACK doesn't include all the capabilities of the original LAPACK library.
# So to get all LAPACK functionality, a separate LAPACK library is necessary.

# There are many attempts at writing a C/C++ LAPACK library, but few have succeeded.
# - LAPACK++ stopped development in 2010, and doesn't include all the capabilities of the original LAPACK library.
# - IT++ stopped development in 2013, and doesn't include all the capabilities of the original LAPACK library.
# - MKL (Intel Math Kernel Library) works on Intel platforms only.
# - ACML (AMD Core Math Library) reached end of life and is no longer available.  Also has/had a restrictive license.
# - CLAPACK is a "Fortran to C" conversion project.  Last update 2009.  But I was able to compile it...  And it has cmake...

# CLAPACK has its own BLAS (looks like another "Fortran to C" conversion, probably from the original Fortran 77 BLAS)

# xtensor | xtensor-blas | FLENS BLAS
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | BLAS (that comes with CLAPACK)

# xtensor | xtensor-blas | FLENS BLAS with OpenBLAS 
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | BLAS (that comes with CLAPACK)

# xtensor | xtensor-blas | FLENS BLAS with BLIS
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | BLAS (that comes with CLAPACK)



#use_flens = true

# Let's try the easiest case first.  At least, I think this is the easiest case.
# xtensor | xtensor-blas | FLENS BLAS
# xtensor | xtensor-blas | FLENS LAPACK with CLAPACK | BLAS (that comes with CLAPACK)
#
# We need to do the following:
# - Tell xtensor-blas to use FLENS LAPACK (as API).  (Will it automatically use CLAPACK's BLAS since we link it in?)
# - Tell xtensor-blas to use FLENS BLAS implementation (not using external BLAS library)
# - Tell FLENS LAPACK to use CLAPACK
# - Let CLAPACK use its own BLAS implementation

# Option:  LAPACK_LIB=CLAPACK
# Option:  BLAS_LIB=FLENS_BLAS

#dependency('ZLIB', method : 'cmake', modules : ['ZLIB::ZLIB'])
xtensor_blas_deps = [dependency('blas'), dependency('lapack')] # External library installed on the system
# FIXME:  Had to install liblapack-dev, libblas-dev to get this to work

# Fedora specfically requires 'cblas' for reasons unknown
if (host_machine.system() == 'linux')
    os_name = run_command('head', '-1', '/etc/os-release').stdout().strip()
    if (os_name == 'NAME=Fedora')
        xtensor_blas_deps += [dependency('cblas')]
    endif
endif

xtensor_blas_dep = declare_dependency(include_directories: xtensor_includes,
                                      dependencies: xtensor_blas_deps,
                                      compile_args: xtensor_blas_cpp_arg)


