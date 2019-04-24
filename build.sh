#!/usr/bin/env bash
rm -rf zips && mkdir zips
pushd patches
for i in */; do zip -r "../zips/${i%/}-patches.zip" "$i"; done
popd
