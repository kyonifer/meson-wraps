project('pybind11', 'cpp', default_options : ['cpp_std=c++14'], license : 'BSD-style', version : '2.2.4')

python3 = import('python').find_installation('python3')

py3_dep = python3.dependency(embed: true)

pybind11_incdir = include_directories('include')

if py3_dep.found()
    pybind11_dep = declare_dependency(
        include_directories : pybind11_incdir,
        dependencies : py3_dep)
else
    # Return a "not found" dependency
    pybind11_dp = dependency('', required: false)
endif

# Workaround from mesonbuild/meson github issue 2550
if meson.is_subproject()
    install_dir = get_option('subproj_includedir')
    extra_cflags = '-I' + get_option('prefix') / install_dir
else
    install_dir = get_option('includedir')
    extra_cflags = ''
endif

install_subdir('include/pybind11', install_dir: install_dir)

pkgconfig = import('pkgconfig')
pkgconfig.generate(name: 'pybind11',
    version: meson.project_version(),
    description: 'Seamless operability between C++11 and Python',
    requires: 'python3',
    extra_cflags: extra_cflags)
