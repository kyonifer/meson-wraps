project('pystring', 'cpp',
        version:'1.1.3',
        license:'BSD-3-Clause')


pystring_lib = static_library(
        'pystring',
        'pystring.cpp',
        override_options: ['debug=false', 'optimization=3'])

pystring_dep = declare_dependency(
    link_with: pystring_lib,
    include_directories: include_directories('.', is_system: true))


