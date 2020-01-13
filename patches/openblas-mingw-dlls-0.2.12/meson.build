project('openblas-mingw-dlls', 'cpp',
    version:'0.2.12',
    license:'MIT')
# It's unclear which version of MinGW these DLLs came from.  They are either an MIT-style license (version 4.0+) or public domain (before 4.0).
# http://www.mingw.org/license

openblas_mingw_dlls_dep = []

if host_machine.system() == 'windows'
    cc = meson.get_compiler('cpp')
    prebuilt_gcc_seh_dll = cc.find_library('gcc_s_seh-1', dirs: [meson.current_source_dir() + '/mingw64_dll'], required: false)
    prebuilt_gfortran_dll = cc.find_library('gfortran-3', dirs: [meson.current_source_dir() + '/mingw64_dll'], required: false)
    prebuilt_quadmath_dll = cc.find_library('quadmath-0', dirs: [meson.current_source_dir() + '/mingw64_dll'], required: false)
    
    openblas_mingw_dlls_dep = declare_dependency(dependencies: [prebuilt_gcc_seh_dll, prebuilt_gfortran_dll, prebuilt_quadmath_dll])
else
    warning('The OpenBLAS MinGW DLLs project will only execute for a Windows target.')
    openblas_mingw_dlls_dep = disabler()
endif
