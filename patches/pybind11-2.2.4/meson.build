project('pybind11', 'cpp', default_options : ['cpp_std=c++14'], license : 'BSD-style', version : '2.2.4')

py3_dep = dependency('python3')

pybind11_incdir = include_directories('include')

pybind11_dep = declare_dependency(
	include_directories : pybind11_incdir,
	dependencies : py3_dep
)

