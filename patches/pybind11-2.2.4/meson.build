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
