project('xtensor-julia',
    'cpp',
    version:'0.8.2',
    license:'BSD-3-Clause',
    default_options : ['warning_level=3', 'cpp_std=c++14'])

xtensor_dep = dependency('xtensor',
    version:'>=0.20.4',
    fallback : ['xtensor', 'xtensor_dep'] )

cc = meson.get_compiler('cpp')
python = import('python').find_installation('python3')
# See if the directory exists, then translate Python boolean value to POSIX return code
py_find_dir = 'import os; exists = os.path.isdir(\'@0@\'); exit(not(exists))'

problem = false

## Hunt for libjulia and julia's headers

julia = find_program('julia', required: false)

if (julia.found())
    julia_pre_command = ['julia', '--startup-file=no', '-e']

    julia_libdir = run_command(julia_pre_command +
        ['using Libdl;print(abspath(dirname(Libdl.dlpath("libjulia"))))']).stdout().strip()

    if julia_libdir == ''
        julia_libdir = '/usr/lib'
    endif

    julia_lib = cc.find_library('julia', dirs : [julia_libdir], required: false)

    if (not julia_lib.found())
        problem = true
    endif

    julia_incdir = run_command(julia_pre_command +
        ['print(joinpath(match(r"(.*)(bin)",Sys.BINDIR).captures[1],"include","julia"))']).stdout().strip()


    julia_incdir_exists = run_command(python, ['-c', py_find_dir.format(julia_incdir)]).returncode()

    if (not problem) and (julia_incdir_exists != 0)
        warning('Could not locate Julia include directory. Disabling Julia bindings.')
        problem = true
    else
        julia_incdir = include_directories(julia_incdir, is_system: true)
    endif

    ## Hunt for the cxxwrap lib and headers installed by CxxWrap.

    # We can't subproject `libcxxwrap-julia` ourselves, because if
    # the versions differ we'll link against a different version
    # than CxxWrap.jl loads at runtime.

    cxxwrap_libdir = run_command(julia_pre_command +
        ['using CxxWrap;print(dirname(CxxWrap.libcxxwrap_julia))']).stdout().strip()

    if (cxxwrap_libdir == '')
        cxxwrap_libdir = '/usr/lib'
    endif

    cxxwrap_lib = cc.find_library('libcxxwrap_julia', dirs : cxxwrap_libdir, required: false)

    cxxwrap_incdir = run_command(julia_pre_command +
        ['using CxxWrap;print(joinpath(CxxWrap.prefix().path, "include"))']).stdout().strip()

    cxxwrap_incdir_exists = run_command(python, ['-c', py_find_dir.format(cxxwrap_incdir)]).returncode()

    if (not problem) and (cxxwrap_incdir_exists != 0)
        warning('CxxWrap headers not found in Julia installation. Disabling Julia bindings.')
        problem = true
    else
        cxxwrap_incdir = include_directories(cxxwrap_incdir, is_system: true)
    endif
else
    problem = true
endif

if (not problem)
    xtensor_julia_dep = declare_dependency(
        include_directories:[include_directories('include', is_system: true),
            julia_incdir,
            cxxwrap_incdir],
        dependencies:[xtensor_dep, cxxwrap_lib, julia_lib],
        compile_args : ['-DJLCXX_EXPORTS', '-DJULIA_ENABLE_THREADING', '-Dcxxwrap_julia_EXPORTS'])
else
    xtensor_julia_dep = dependency('', required: false)
endif
