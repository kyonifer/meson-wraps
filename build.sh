#!/usr/bin/env bash
pushd patches

for i in */; do
    # Use number of commits that occur in the folder as wrap version number
    WRAP_VER=$(git log --oneline ${i} | wc -l)
    FNAME=${i%/}-patches-${WRAP_VER}.zip
    ZIPNAME=../zips/${FNAME}

    if [ ! -f "${ZIPNAME}" ]; then
        zip -r "${ZIPNAME}" "$i" --exclude "${i}upstream.wrap"
    fi
done

popd
