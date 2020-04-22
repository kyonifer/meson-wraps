project('xtensor-python', 'cpp',
        version:'0.24.1',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

not_found_dependency = dependency('', required: false)

pybind_dep = dependency('pybind11',
    version: ['>=2.4.3', '<2.5.0'],
    fallback: ['pybind11', 'pybind11_dep'],
    required: false)

xtensor_dep = dependency('xtensor',
    version: ['>=0.21.2', '<1.0.0'],
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
        include_directories: [include_directories('include', is_system: true),
            include_directories(npy_incstr, is_system: true)],
        dependencies:[xtensor_dep, pybind_dep])
endif

extra_cflags = []

# Workaround from mesonbuild/meson github issue 2550
if meson.is_subproject()
    install_dir = get_option('subproj_includedir')
    extra_cflags += '-I' + get_option('prefix') / install_dir
else
    install_dir = get_option('includedir')
endif

install_subdir('include/xtensor-python', install_dir: install_dir)

pkgconfig = import('pkgconfig')
pkgconfig.generate(name: meson.project_name(),
    version: meson.project_version(),
    description: 'Python bindings for the xtensor C++ multi-dimensional array library.',
    requires: ['xtensor', 'pybind'],
    extra_cflags: extra_cflags)
