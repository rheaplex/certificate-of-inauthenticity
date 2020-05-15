#!/bin/bash

source ./config.sh

SOURCE="template.json"


IPFS_HASH=$(<"${IMAGE_DIR_HASH_FILE}")

IPFS_IMG_ROOT="\/ipfs\/${IPFS_HASH}"
METADATA_DIR="${BUILD_DIR}/ipfs-metadata"


mkdir -p "${METADATA_DIR}"


token_id=1

# For each work
for work in "${WORKS[@]}"
do
    # Make an edition
    # We format the png number as two digits, zero prefixed if needed
    for i in $(seq -f "%02g" 1 $EDITION_EACH)
    do
        nospaces=${work// /}
        # We don't format the json number as two digits, as the contract doesn't
        # No JSON extension so it's easier for the URI function
        filepath="$METADATA_DIR/$token_id"
        pngfilename="$nospaces$i.png"
        # Copy the template to the build dir
        cp "$SOURCE" "$filepath"
        # And fill it out
        perl -i -p -e "s/\@title/$work/" "$filepath"
        perl -i -p -e "s/\@index/$i/" "$filepath"
        perl -i -p -e "s/\@editionsize/$EDITION_EACH/" "$filepath"
        perl -i -p -e "s/\@imgroot/$IPFS_IMG_ROOT/" "$filepath"
        perl -i -p -e "s/\@image/$pngfilename/" "$filepath"
        token_id=$((token_id+1))
    done
done
