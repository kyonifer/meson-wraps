project('xtensor-python', 'cpp',
        version:'0.23.0',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

not_found_dependency = dependency('', required: false)

pybind_dep = dependency('pybind11',
    version: ['>=2.2.1', '<2.3.0'],
    fallback: ['pybind11', 'pybind11_dep'],
    required: false)

xtensor_dep = dependency('xtensor',
    version: ['>=0.20.4', '<1.0.0'],
    fallback : ['xtensor', 'xtensor_dep'],
    required: false)

python = import('python').find_installation('python3')

npy_incstr = run_command(
    [python, '-c', 'import numpy; print(numpy.get_include())'],
    check: false).stdout().strip()

if (npy_incstr == '')
    warning('Unable to find numpy (Looking for it using ' + python.path() +
        '), disabling python bindings.')
endif

if (npy_incstr == '') or (not pybind_dep.found()) or (not xtensor_dep.found())
    xtensor_python_dep = not_found_dependency
else
    xtensor_python_dep = declare_dependency(
        include_directories:[include_directories('include', is_system: true),
            include_directories(npy_incstr, is_system: true)],
        dependencies:[xtensor_dep, pybind_dep])
endif
