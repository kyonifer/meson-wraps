#!/usr/bin/env bash

# To use Docker from bash:
# docker build -t meson_wraps --build-arg USER_ID=$(id -u) .
# docker run -v $(pwd):/work -w /work --rm meson_wraps bash ./build.bash

PATCH_URL=https://github.com/kyonifer/meson-wraps/raw/master/zips/

pushd patches >/dev/null

for i in */; do
    # Use number of commits that occur in the folder as wrap version number
    WRAP_VER=$(git log --oneline $i | wc -l)
    UPSTREAM_WRAP=${i}upstream.wrap
    # Set the PROJECT_NAME to match basename of source_filename in upstream.wrap
    # Print the contents of upstream.wrap, then feed through 2 filters with sed:
    # 1. Match the line that starts with 'source_filename = ' with arbitrary spacing and return everything after that
    # 2. Strip the extension (expecting some kind of archive)
    PROJECT_NAME=$(cat $UPSTREAM_WRAP | sed -n "s/^source_filename[[:space:]]*=[[:space:]]*//p" | sed -E "s/\.(zip|tar|tar\.gz|tar\.bz2|tgz)//")
    FNAME=${PROJECT_NAME}-patches-${WRAP_VER}.zip
    ZIPNAME=../zips/${FNAME}

    if [ ! -f "$ZIPNAME" ]; then
        zip -r "$ZIPNAME" "$i" --exclude "$UPSTREAM_WRAP"

        HASH=$(sha256sum $ZIPNAME | cut -c1-64)
        OUTPUT_WRAP=../wraps/${PROJECT_NAME}/${PROJECT_NAME%-*}.wrap

        mkdir -p ../wraps/${PROJECT_NAME}

        # Add patch url, filename, hash lines to upstream.wrap and save output
        # in the wraps folder
        printf "\n%s\n%s\n%s\n" \
            "patch_url=${PATCH_URL}${FNAME}" \
            "patch_filename=${FNAME}" \
            "patch_hash=${HASH}" |
            cat ${UPSTREAM_WRAP} - >${OUTPUT_WRAP}
    else
        echo "skipping folder ${i%/}"
    fi
done

popd >/dev/null

echo ""
echo "If projects were unexpectedly skipped, commit changes "
echo "to the patch folder in git and rerun."
echo ""
echo "Complete."
