#!/usr/bin/env bash
PATCH_URL=https://github.com/kyonifer/meson-wraps/raw/master/zips/

pushd patches > /dev/null

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
        echo -e "\npatch_url=${PATCH_URL}${FNAME}" \
            "\npatch_filename=${FNAME}" \
            "\npatch_hash=${HASH}" |
            cat ${UPSTREAM_WRAP} - >${OUTPUT_WRAP}
    else
        echo "skipping ${i%/}"
    fi
done

popd > /dev/null

echo ""
echo "If projects were unexpectedly skipped, commit changes "
echo "to the patch folder in git and rerun."
echo ""
echo "Complete."
