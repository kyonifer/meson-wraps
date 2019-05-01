project('xtensor-python', 'cpp',
        version:'0.23.0',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

pybind_dep = subproject('pybind11').get_variable('pybind11_dep')
xtensor_dep = dependency('xtensor',
                         version:'>=0.20.4',
                         fallback : ['xtensor', 'xtensor_dep'] )

python = import('python').find_installation()

npy_incstr = run_command([python, '-c', 'import numpy; print(numpy.get_include())'], check: false).stdout().strip()
if (npy_incstr == '')
    warning('Unable to find numpy (Looking for it using ' + python.path() + ')')
endif

if (npy_incstr == '')
    xtensor_python_dep = disabler()
else
    xtensor_python_dep = declare_dependency(
                        include_directories:[include_directories('include'), include_directories(npy_incstr)],
                        dependencies:[xtensor_dep, pybind_dep])
endif