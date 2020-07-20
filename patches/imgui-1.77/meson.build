project(
  'Dear ImGui core library',
  'cpp',
  license : 'MIT',
  version : '1.76',
)

dearimgui_inc = include_directories(['.', 'examples'])
dearimgui_src = files(
  'imgui.cpp',
  'imgui_draw.cpp',
  'imgui_widgets.cpp',
  'examples/imgui_impl_glfw.cpp',
  'examples/imgui_impl_opengl3.cpp',
  'imgui_demo.cpp'
)

dearimgui_lib = static_library(
  'dearimgui',
  dearimgui_src,
  include_directories : dearimgui_inc,
  dependencies: [dependency('glfw3'), dependency('glew'), dependency('gl')]
)

dearimgui_dep = declare_dependency(
  link_with : dearimgui_lib,
  include_directories : dearimgui_inc,
)
