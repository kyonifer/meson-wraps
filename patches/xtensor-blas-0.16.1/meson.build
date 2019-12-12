project('xtensor-blas', 'cpp',
    version:'0.16.1',
    license:'BSD-3-Clause',
    default_options : ['warning_level=3', 'cpp_std=c++14'])

xtensor_blas_deps = [dependency('xtensor',
    version:'>=0.20.0',
    fallback: ['xtensor', 'xtensor_dep'] )]

xtensor_blas_cpp_arg = []
xtensor_blas_includes = [include_directories('include', is_system: true)]

# xtensor-blas is an interface between xtensor and BLAS/LAPACK.  It enables use of xlinalg.hpp functions in xtensor.
# BLAS is a collection of low-level matrix and vector arithmetic operations.  Basic Linear Algebra Subprograms
# LAPACK is a collection of higher-level linear algebra operations.  Linear Algebra PACKage
# netlib maintains a reference implementation of each (www.netlib.org). Their APIs have been used to create 
# better performing libraries over the years.

# The build machine should provide a BLAS implementation and a LAPACK implementation.  

# Here we begin the long journey of attempting to find BLAS and LAPACK libraries.
blas_lapack_found = false

# Our first choice is OpenBLAS, if that is installed on the system.
# Although not advertised, OpenBLAS provdies a complete LAPACK implementation, partially optimized.
if not blas_lapack_found
    system_installed_openblas = dependency('openblas', required: false)

    if system_installed_openblas.found()
        blas_lapack_found = true
        xtensor_blas_deps += [system_installed_openblas]
    endif
endif

# Our next choice for Mac is the Accelerate framework
if (not blas_lapack_found) and (host_machine.system() == 'darwin')

    # TODO for Mac:  try accelerate
    blas_lapack_found = false

endif

# Our next choice could be MKL (Intel Math Kernel Library) for Intel platforms
if not blas_lapack_found
    blas_lapack_found = false
endif

# Our next choice is system-installed BLAS and LAPACK libraries
if not blas_lapack_found
    
    system_installed_blas = dependency('blas', required: false)
    system_installed_lapack = dependency('lapack', required: false)
    
    if system_installed_blas.found() and system_installed_lapack.found()
        blas_lapack_found =  true
        xtensor_blas_deps += [system_installed_lapack, system_installed_blas]
    endif

    # Fedora specfically requires 'cblas' for reasons unknown
    if blas_lapack_found and (host_machine.system() == 'linux')
        os_name = run_command('head', '-1', '/etc/os-release').stdout().strip()
        if (os_name == 'NAME=Fedora')
            xtensor_blas_deps += [dependency('cblas')]
        endif
    endif
    
endif

# Our next choice for Windows are the prebuilt OpenBLAS libraries that we included with the Meson wrap.
if (not blas_lapack_found) and (host_machine.system() == 'windows')
    cc = meson.get_compiler('cpp')
    # Download location:  https://ayera.dl.sourceforge.net/project/openblas/v0.3.7/OpenBLAS-0.3.7-x64.zip
    prebuilt_openblas_dep = cc.find_library('openblas', dirs: [meson.current_source_dir() + '/windows-x64-libs'], required: false)
    # Download location:  https://newcontinuum.dl.sourceforge.net/project/openblas/v0.2.12/mingw64_dll.zip
    prebuilt_gfortran_dep = cc.find_library('gfortran-3', dirs: [meson.current_source_dir() + '/windows-x64-libs'], required: false)
    
    if prebuilt_openblas_dep.found() and prebuilt_gfortran_dep.found()
        blas_lapack_found = true
        xtensor_blas_deps += [prebuilt_openblas_dep, prebuilt_gfortran_dep]
        warning('BLAS and LAPACK were not found installed on the system.  Falling back to prebuilt OpenBLAS.')
    endif

endif

# Our next choice is to try to build a library included as a subproject.
if not blas_lapack_found

    # Top contenders include:
    # - OpenBLAS
    #   * Provides an optimized BLAS 
    #   * Although not advertised, provdies a complete LAPACK implementation, partially optimized.
    # - BLIS - https://github.com/flame/blis 
    #   * Provides BLAS compatibility.  Claims to be faster than OpenBLAS.
    #   * Unclear if it provides any LAPACK functions.
    # - Flame - https://github.com/flame/libflame 
    #   * Provides some optimized LAPACK functions
    #   * For LAPACK functions that aren't optimized, they also have a complete reference implementation.
    #   * Provides some kind of BLAS, but should be able to interoperate with BLIS

    blas_lapack_found = false

endif

# A last resort is to try to use FLENS BLAS and FLENS LAPACK that come with xtensor-blas.
if not blas_lapack_found
    # FLENS BLAS is a complete implementation of BLAS, but FLENS LAPACK is not a complete implementation of LAPACK. 
    # This doesn't seem to really be an option, as STK requires LAPACK functions that aren't in FLENS LAPACK.  
    # But if you'd like to give it a try, uncomment the following line and set blas_lapack_found to true.
    # xtensor_blas_cpp_arg += ['-DXTENSOR_USE_FLENS_BLAS']
    blas_lapack_found = false
endif

# At this point, we are tired of trying to accommodate BLAS and LAPACK
assert(blas_lapack_found, 'BLAS and LAPACK not found.  They are required for xtensor-blas.')

xtensor_blas_dep = declare_dependency(include_directories: xtensor_blas_includes,
                                      dependencies: xtensor_blas_deps,
                                      compile_args: xtensor_blas_cpp_arg)
