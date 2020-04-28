#!/bin/bash

source ./config.sh

SOURCE="template.json"
IMAGES_DIR="${BUILD_DIR}/images"
JSON_DIR="${BUILD_DIR}/json"

IPFS_HASH=$(<ipfs-image-dir-hash)

mkdir -p "${JSON_DIR}"

# For each work
for work in "${WORKS[@]}"
do
    # Make an edition
    for ((i=1; i <= ${EDITION_EACH}; i++))
    do
        nospaces=${work// /}
        filepath="$JSON_DIR/$nospaces$i.json"
        pngfilename="$nospaces$i.png"
        # Copy the template to the build dir
        cp "$SOURCE" "$filepath"
        # And fill it out
        perl -i -p -e "s/\@title/$work/" "$filepath"
        perl -i -p -e "s/\@index/$i/" "$filepath"
        perl -i -p -e "s/\@editionsize/$EDITION_EACH/" "$filepath"
        perl -i -p -e "s/\@ipfshash/$IPFS_HASH/" "$filepath"
        perl -i -p -e "s/\@image/$pngfilename/" "$filepath"
    done
done
