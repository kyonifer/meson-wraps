project('nlohmann_json',
    'cpp',
    version : '3.5.0',
    license : 'MIT',
)

nlohmann_json_dep = declare_dependency(
    include_directories: include_directories('single_include')
)

nlohmann_json_multiple_headers = declare_dependency(
    include_directories: include_directories('include')
)

# Workaround from mesonbuild/meson github issue 2550
if meson.is_subproject()
    install_dir = get_option('subproj_includedir')
    extra_cflags = '-I' + get_option('prefix') / install_dir
else
    install_dir = get_option('includedir')
    extra_cflags = ''
endif

install_subdir('single_include/nlohmann', install_dir: install_dir)

pkgc = import('pkgconfig')
pkgc.generate(name: 'nlohmann_json',
    version: meson.project_version(),
    description: 'JSON for Modern C++',
    extra_cflags: extra_cflags)
