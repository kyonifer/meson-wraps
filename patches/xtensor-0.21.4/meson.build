project('xtensor', 'cpp',
        version:'0.21.4',
        license:'BSD-3-Clause',
        default_options : ['warning_level=3', 'cpp_std=c++14'])

xtl_dep = dependency('xtl',
    version:'>=0.6.3',
    fallback : ['xtl', 'xtl_dep'],
    required: false)

json_dep = dependency('nlohmann_json',
    version:'>=3.1.1',
    fallback : ['nlohmann_json', 'nlohmann_json_dep'],
    required: false)

all_deps_found = json_dep.found() and xtl_dep.found()

if get_option('XTENSOR_USE_XSIMD')
    xsimd_dep = dependency('xsimd',
        version:'>=7.0.0',
        fallback : ['xsimd', 'xsimd_dep'],
        required: false)
    xtensor_cpp_arg = ['-DXTENSOR_USE_XSIMD']
    all_deps_found = all_deps_found and xsimd_dep.found()
else
    xsimd_dep = dependency('', required: false) # aka "not found"
    xtensor_cpp_arg = []
endif

if all_deps_found
    xtensor_dep = declare_dependency(
        include_directories:include_directories('include', is_system: true),
        dependencies: [xtl_dep, json_dep, xsimd_dep],
        compile_args: xtensor_cpp_arg)
else
    xtensor_dep = dependency('', required: false) # aka "not found"
endif

install_headers(
    'include/xtensor/xaccessible.hpp',
    'include/xtensor/xaccumulator.hpp',
    'include/xtensor/xadapt.hpp',
    'include/xtensor/xarray.hpp',
    'include/xtensor/xassign.hpp',
    'include/xtensor/xaxis_iterator.hpp',
    'include/xtensor/xbroadcast.hpp',
    'include/xtensor/xbuffer_adaptor.hpp',
    'include/xtensor/xbuilder.hpp',
    'include/xtensor/xcomplex.hpp',
    'include/xtensor/xcontainer.hpp',
    'include/xtensor/xcsv.hpp',
    'include/xtensor/xdynamic_view.hpp',
    'include/xtensor/xeval.hpp',
    'include/xtensor/xexception.hpp',
    'include/xtensor/xexpression_holder.hpp',
    'include/xtensor/xexpression.hpp',
    'include/xtensor/xexpression_traits.hpp',
    'include/xtensor/xfixed.hpp',
    'include/xtensor/xfunction.hpp',
    'include/xtensor/xfunctor_view.hpp',
    'include/xtensor/xgenerator.hpp',
    'include/xtensor/xhistogram.hpp',
    'include/xtensor/xindex_view.hpp',
    'include/xtensor/xinfo.hpp',
    'include/xtensor/xio.hpp',
    'include/xtensor/xiterable.hpp',
    'include/xtensor/xiterator.hpp',
    'include/xtensor/xjson.hpp',
    'include/xtensor/xlayout.hpp',
    'include/xtensor/xmanipulation.hpp',
    'include/xtensor/xmasked_view.hpp',
    'include/xtensor/xmath.hpp',
    'include/xtensor/xmime.hpp',
    'include/xtensor/xnoalias.hpp',
    'include/xtensor/xnorm.hpp',
    'include/xtensor/xnpy.hpp',
    'include/xtensor/xoffset_view.hpp',
    'include/xtensor/xoperation.hpp',
    'include/xtensor/xoptional_assembly_base.hpp',
    'include/xtensor/xoptional_assembly.hpp',
    'include/xtensor/xoptional_assembly_storage.hpp',
    'include/xtensor/xoptional.hpp',
    'include/xtensor/xpad.hpp',
    'include/xtensor/xrandom.hpp',
    'include/xtensor/xreducer.hpp',
    'include/xtensor/xscalar.hpp',
    'include/xtensor/xsemantic.hpp',
    'include/xtensor/xshape.hpp',
    'include/xtensor/xslice.hpp',
    'include/xtensor/xsort.hpp',
    'include/xtensor/xstorage.hpp',
    'include/xtensor/xstrided_view_base.hpp',
    'include/xtensor/xstrided_view.hpp',
    'include/xtensor/xstrides.hpp',
    'include/xtensor/xtensor_config.hpp',
    'include/xtensor/xtensor_forward.hpp',
    'include/xtensor/xtensor.hpp',
    'include/xtensor/xtensor_simd.hpp',
    'include/xtensor/xutils.hpp',
    'include/xtensor/xvectorize.hpp',
    'include/xtensor/xview.hpp',
    'include/xtensor/xview_utils.hpp',
    subdir: 'xtensor')
