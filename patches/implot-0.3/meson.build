project(
  'ImGui Plotting Library',
  'cpp',
  license : 'MIT',
  version : '0.3',
)

dearimgui_dep = subproject('dearimgui').get_variable('dearimgui_dep')

implot_inc = include_directories(['.'])
implot_src = files(
  'implot.cpp',
  'implot_demo.cpp'
)

implot_lib = static_library(
  'implot',
  implot_src,
  include_directories : implot_inc,
  dependencies: [dearimgui_dep]
)

implot_dep = declare_dependency(
  link_with : implot_lib,
  include_directories : implot_inc
)
