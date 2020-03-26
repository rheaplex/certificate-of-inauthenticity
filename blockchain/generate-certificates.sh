#!/bin/bash

source ./config.sh

SOURCE="template.svg"
IMAGES_DIR="${BUILD_DIR}/images"

# The date for the certificates
DATE=$(date +%Y-%m-%d)
echo $DATE

# Ensure the build dirs exists
mkdir -p "${BUILD_DIR}"
mkdir -p "${IMAGES_DIR}"

# For each work
for work in "${WORKS[@]}"
do
    # Make an edition
    for ((i=1; i <= 12; i++))
    do
        nospaces=${work// /}
        filepath="$IMAGES_DIR/$nospaces$i.svg"
        pdffilepath="$IMAGES_DIR/$nospaces$i.pdf"
        pngfilepath="$IMAGES_DIR/$nospaces$i.png"
        echo "$filepath"
        # Copy the template to the build dir
        cp "$SOURCE" "$filepath"
        #inkscape "$SOURCE" --export-plain-svg="$filepath"
        # And fill it out
        perl -i -p -e "s/\@title/$work/" "$filepath"
        perl -i -p -e "s/\@i/$i/" "$filepath"
        perl -i -p -e "s/\@n/$EDITION_EACH/" "$filepath"
        perl -i -p -e "s/XXXX-XX-XX/$DATE/" "$filepath"
        # Then convert it to PDF
        inkscape "$filepath" --export-pdf="$pdffilepath"
        # And convert it to PNG
        inkscape "$filepath" --export-png="$pngfilepath"
    done
done
