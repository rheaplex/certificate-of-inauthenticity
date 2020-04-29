#!/bin/bash

source ./config.sh

SOURCE="template.svg"

# The date for the certificates
DATE=$(date +%Y-%m-%d)
echo $DATE

# Ensure the build dirs exists
mkdir -p "${BUILD_DIR}"
mkdir -p "${CERTIFICATES_DIR}"

# For each work
for work in "${WORKS[@]}"
do
    # Make an edition
    for i in $(seq -f "%02g" 1 $EDITION_EACH)
    do
        nospaces=${work// /}
        filepath="$CERTIFICATES_DIR/$nospaces$i.svg"
        pdffilepath="$CERTIFICATES_DIR/$nospaces$i.pdf"
        pngfilepath="$CERTIFICATES_DIR/$nospaces$i.png"
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
