project('xtensor', 'cpp',
        version:'0.21.4',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

xtensor_dependencies = [dependency('xtl',
                                   version:'>=0.6.3',
                                   fallback : ['xtl', 'xtl_dep'] ),
                        dependency('nlohmann_json',
                                   version:'>=3.1.1',
                                   fallback : ['nlohmann_json', 'nlohmann_json_dep'] )
                                   ]
xtensor_cpp_arg = []

if get_option('XTENSOR_USE_XSIMD')
  xtensor_dependencies+=[dependency('xsimd', version:'>=7.0.0', fallback : ['xsimd', 'xsimd_dep'])]
  xtensor_cpp_arg = ['-DXTENSOR_USE_XSIMD']
endif

xtensor_dep = declare_dependency(include_directories:include_directories('include', is_system: true),
                                 dependencies:xtensor_dependencies,
                                 compile_args:xtensor_cpp_arg)


