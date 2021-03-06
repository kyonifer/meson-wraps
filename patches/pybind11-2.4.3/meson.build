project('pybind11', 'cpp', default_options : ['cpp_std=c++14'], license : 'BSD-style', version : '2.4.3')

python3 = import('python').find_installation('python3')

libpython3_dep = python3.dependency()
# Do not include the library, as might be found through pkg-config
py3_dep = libpython3_dep.partial_dependency(compile_args: true)

pybind11_incdir = include_directories('include')

compile_args = []

if meson.get_compiler('cpp').get_id() == 'clang'
    # https://github.com/pybind/pybind11/issues/1604
    compile_args += '-fsized-deallocation'
endif

if py3_dep.found()
    pybind11_dep = declare_dependency(
        compile_args : compile_args,
        include_directories : pybind11_incdir,
        dependencies : py3_dep)
else
    # Return a "not found" dependency
    pybind11_dp = dependency('', required: false)
endif

extra_cflags = compile_args

# Adding "python3" to the requires line in pkg-config could pull in the library;
# only add the path to the Python headers
extra_cflags += '-I' + python3.get_path('include')

# Workaround from mesonbuild/meson github issue 2550
if meson.is_subproject()
    install_dir = get_option('subproj_includedir')
    extra_cflags += '-I' + get_option('prefix') / install_dir
else
    install_dir = get_option('includedir')
endif

install_subdir('include/pybind11', install_dir: install_dir)

pkgconfig = import('pkgconfig')
pkgconfig.generate(name: 'pybind11',
    version: meson.project_version(),
    description: 'Seamless operability between C++11 and Python',
    extra_cflags: extra_cflags)
