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

install_headers(
    'include/pybind11/attr.h',
    'include/pybind11/buffer_info.h',
    'include/pybind11/cast.h',
    'include/pybind11/chrono.h',
    'include/pybind11/common.h',
    'include/pybind11/complex.h',
    'include/pybind11/eigen.h',
    'include/pybind11/embed.h',
    'include/pybind11/eval.h',
    'include/pybind11/functional.h',
    'include/pybind11/iostream.h',
    'include/pybind11/numpy.h',
    'include/pybind11/operators.h',
    'include/pybind11/options.h',
    'include/pybind11/pybind11.h',
    'include/pybind11/pytypes.h',
    'include/pybind11/stl_bind.h',
    'include/pybind11/stl.h',
    subdir: 'pybind11')

install_headers(
    'include/pybind11/detail/class.h',
    'include/pybind11/detail/common.h',
    'include/pybind11/detail/descr.h',
    'include/pybind11/detail/init.h',
    'include/pybind11/detail/internals.h',
    'include/pybind11/detail/typeid.h',
    subdir: 'pybind11/detail')

pkgconfig = import('pkgconfig')
pkgconfig.generate(name: 'pybind11',
    version: meson.project_version(),
    description: 'Seamless operability between C++11 and Python',
    requires: 'python3')
