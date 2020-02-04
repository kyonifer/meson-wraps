#!/usr/bin/env bash
#PATCH_URL=https://github.com/kyonifer/meson-wraps/raw/master/zips/
PATCH_URL=https://github.com/UnoccupiedColonist/meson-wraps/raw/wrap_version/zips/

pushd patches

for i in */; do
    # Use number of commits that occur in the folder as wrap version number
    WRAP_VER=$(git log --oneline $i | wc -l)
    FNAME=${i%/}-patches-${WRAP_VER}.zip
    ZIPNAME=../zips/${FNAME}
    UPSTREAM_WRAP=${i}upstream.wrap

    if [ ! -f "$ZIPNAME" ]; then
        zip -r "$ZIPNAME" "$i" --exclude "$UPSTREAM_WRAP"

        HASH=$(sha256sum $ZIPNAME | cut -c1-64)
        OUTPUT_WRAP=../wraps/${i%-*/}.wrap

        # Add patch url, filename, hash lines to upstream.wrap and save output
        # in the wraps folder
        echo -e "\n" \
            "patch_url=${PATCH_URL}${FNAME}\n" \
            "patch_filename=${FNAME}\n" \
            "patch_hash=${HASH}\n" |
            cat ${UPSTREAM_WRAP} - >${OUTPUT_WRAP}
    fi
done

popd
