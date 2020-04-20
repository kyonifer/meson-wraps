project('xtensor', 'cpp',
        version:'0.20.4',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

xtl_dep = dependency('xtl',
    version: ['>=0.6.2', '<1.0.0'],
    fallback : ['xtl', 'xtl_dep'],
    required: false)

json_dep = dependency('nlohmann_json',
    version:'>=3.1.1',
    fallback : ['nlohmann_json', 'nlohmann_json_dep'],
    required: false)

required_deps_found = xtl_dep.found()

if get_option('XTENSOR_USE_XSIMD')
    xsimd_dep = dependency('xsimd',
        version: ['>=7.0.0', '<8.0.0'],
        fallback : ['xsimd', 'xsimd_dep'],
        required: false)
    xtensor_cpp_arg = ['-DXTENSOR_USE_XSIMD']
    required_deps_found = required_deps_found and xsimd_dep.found()
else
    xsimd_dep = dependency('', required: false) # aka "not found"
    xtensor_cpp_arg = []
endif

if required_deps_found
    xtensor_dep = declare_dependency(
        include_directories:include_directories('include', is_system: true),
        dependencies: [xtl_dep, json_dep, xsimd_dep],
        compile_args: xtensor_cpp_arg)
else
    xtensor_dep = dependency('', required: false) # aka "not found"
endif
