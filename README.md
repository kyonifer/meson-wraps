The purpose of this repository is to test new or modified wrap files.  Ultimately they should be added to meson wrapdb following the instructions in the [Meson documentation](https://mesonbuild.com/Wrap-dependency-system-manual.html).

----

To add a new project or version of a project:

1. Create a new subfolder in `patches` named 'project-version'.  
1. Inside this subfolder place the meson.build file(s) as they would apply to the project
1. Also add an `upstream.wrap` file following this template:
    ```
    [wrap-file]
    directory=project-0.1

    source_url=https://example.com/download/0.1/project-0.1.zip
    source_filename=project-0.1.zip
    source_hash=0000000000000000000000000000000000000000000000000000000000000000
    ```
1. Review the output files (optional)
    1. Run the `build.bash` script.  (Note that the wrap patch version should be 0.)
    1. Review the zip file created in the zips folder.
    1. Review the wrap file created in the wraps folder.
    1. **IMPORTANT:** Delete the zip file and wrap file created.
1. **IMPORTANT:** Commit the new files in the patch folder.
1. Run the `build.bash` script.  (Note that the wrap patch version should be 1.)
1. Commit the new zip file and wrap file with patch version 1.

----

To modify an existing project:

1. Make required changes to an existing subfolder inside the `patches` folder.
1. **IMPORTANT:** Commit the new files in the patch folder.
1. Commit the changes so that the wrap version will increment properly.
1. Run the `build.bash` script.
1. Review the updated zip file generated in the zips folder.
1. Review the updated wrap file generated in the wraps folder.
1. If the updated files are not correct, delete them, undo the last commit in git, and then go back to step 1.
1. Commit and push the updated zip and wrap files.

----

To help differentiate and avoid potential naming conflicts when these projects are eventually added to wrapdb, the format of the zip file name differs from that of zip files downloaded from wrapdb.

Wrapdb:  `project-%ver-%wrapver-wrap.zip`

Here:    `project-%ver-patches-$wrapver.zip`

----

For more information, see [Meson's wrap documentation](https://mesonbuild.com/Wrap-dependency-system-manual.html).

Tools to generate `upstream.wrap` as well as extract the meson.build files from a source tree are provided by Meson in the [wrapdevtools repo](https://github.com/mesonbuild/wrapdevtools).  An example of using these tools is available [here](https://wrapdevtools.readthedocs.io/en/latest/workflows/wrapping-glfw.html).
