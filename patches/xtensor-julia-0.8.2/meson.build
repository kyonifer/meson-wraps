project('xtensor-julia', 'cpp',
        version:'0.8.2',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])


xtensor_dep = dependency('xtensor',
                         version:'>=0.20.4',
                         fallback : ['xtensor', 'xtensor_dep'] )

cc = meson.get_compiler('cpp')

## Hunt for libjulia and julia's headers

julia = find_program('julia', required: false)

if (julia.found())
    julia_libdir = run_command(['julia',
                        '--startup-file=no',
                        '-e',
                        'using Libdl;print(abspath(dirname(Libdl.dlpath("libjulia"))))'
                    ], check: false).stdout().strip()
    if (julia_libdir == '')
        julia_libdir = disabler()
    endif
    julia_incdir = run_command(['julia',
                                           '--startup-file=no',
                                           '-e',
                                           'julia_include_dir = print(joinpath(match(r"(.*)(bin)",Sys.BINDIR).captures[1],"include","julia"))'
                                       ], check: false).stdout().strip()
    if (julia_incdir == '')
        julia_incdir = disabler()
    else
        julia_incdir = include_directories(julia_incdir)
    endif
    julia_lib = cc.find_library('julia',
                        dirs : [julia_libdir],
                        required : false)
    if (not julia_lib.found())
        julia_lib = disabler()
    endif

    ## Hunt for the cxxwrap lib and headers installed by CxxWrap.

    # We can't subproject `libcxxwrap-julia` ourselves, because if
    # the versions differ we'll link against a different version
    # than CxxWrap.jl loads at runtime.

    cxxwrap_libdir = run_command(['julia',
                        '--startup-file=no',
                        '-e',
                        'using CxxWrap;print(dirname(CxxWrap.libcxxwrap_julia))'
                    ], check: false).stdout().strip()
    if (cxxwrap_libdir == '')
    warning('CxxWrap libdir not found in Julia installation. Disabling Julia bindings.')
    cxxwrap_libdir = disabler()
    endif

    cxxwrap_incdir = run_command(['julia',
                                        '--startup-file=no',
                                        '-e',
                                        'using CxxWrap;print(joinpath(CxxWrap.prefix().path, "include"))'
                                    ], check: false).stdout().strip()
    if (cxxwrap_incdir == '')
    warning('CxxWrap headers not found in Julia installation. Disabling Julia bindings.')
    cxxwrap_incdir = disabler()
    else
        cxxwrap_incdir = include_directories(cxxwrap_incdir)
    endif

    cxxwrap_lib = cc.find_library('libcxxwrap_julia', dirs : cxxwrap_libdir, required: false)
    if (not cxxwrap_lib.found())
    warning('CxxWrap library not found in Julia installation. Disabling Julia bindings.')
    cxxwrap_lib = disabler()
    endif

    ## Define our dep

    xtensor_julia_dep = declare_dependency(
                        include_directories:[include_directories('include'),
                            julia_incdir,
                            cxxwrap_incdir],
                        dependencies:[xtensor_dep, cxxwrap_lib, julia_lib],
                        compile_args : ['-DJLCXX_EXPORTS', '-DJULIA_ENABLE_THREADING', '-Dcxxwrap_julia_EXPORTS'])

else
    xtensor_julia_dep = disabler()
endif
