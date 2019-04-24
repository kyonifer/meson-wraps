project('xtensor-julia', 'cpp',
        version:'0.8.2',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])


xtensor_dep = dependency('xtensor',
                         version:'>=0.20.4',
                         fallback : ['xtensor', 'xtensor_dep'] )

cc = meson.get_compiler('cpp')

## Hunt for libjulia and julia's headers

julia_libdir = run_command(['julia',
                    '--startup-file=no',
                    '-e',
                    'using Libdl;print(abspath(dirname(Libdl.dlpath("libjulia"))))'
                ], check: true).stdout().strip()
julia_incdir = include_directories(run_command(['julia',
                    '--startup-file=no',
                    '-e',
                    'julia_include_dir = print(joinpath(match(r"(.*)(bin)",Sys.BINDIR).captures[1],"include","julia"))'
                ], check: true).stdout().strip(), is_system : true)
julia_lib = cc.find_library('julia',
                    dirs : [julia_libdir])

## Hunt for the cxxwrap lib and headers installed by CxxWrap.

# We can't subproject `libcxxwrap-julia` ourselves, because if
# the versions differ we'll link against a different version
# than CxxWrap.jl loads at runtime.

# TODO: Check if the user has done a `Pkg.add('CxxWrap')`, and if not complain & abort

cxxwrap_libdir = run_command(['julia',
                    '--startup-file=no',
                    '-e',
                    'using CxxWrap;print(dirname(CxxWrap.libcxxwrap_julia))'
                ], check: true).stdout().strip()
cxxwrap_incdir = include_directories(run_command(['julia',
                    '--startup-file=no',
                    '-e',
                    'using CxxWrap;print(joinpath(CxxWrap.prefix().path, "include"))'
                ], check: true).stdout().strip(), is_system : true)
cxxwrap_lib = cc.find_library('libcxxwrap_julia', dirs : cxxwrap_libdir)

## Define our dep

xtensor_julia_dep = declare_dependency(
                    include_directories:[include_directories('include'),
                        julia_incdir,
                        cxxwrap_incdir],
                    dependencies:[xtensor_dep, cxxwrap_lib, julia_lib],
                    compile_args : ['-DJLCXX_EXPORTS', '-DJULIA_ENABLE_THREADING', '-Dcxxwrap_julia_EXPORTS'])



