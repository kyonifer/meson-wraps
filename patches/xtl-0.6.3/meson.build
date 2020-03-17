project('xtl', 'cpp', version:'0.6.3', license:'BSD-3-Clause', default_options : ['warning_level=3', 'cpp_std=c++14'])

xtl_dep = declare_dependency(include_directories:include_directories('include', is_system: true))

# Workaround from mesonbuild/meson github issue 2550
if meson.is_subproject()
    install_dir = get_option('subproj_includedir')
else
    install_dir = get_option('includedir')
endif

install_subdir('include/xtl', install_dir: install_dir)
