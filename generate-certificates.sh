#!/bin/bash
SOURCE=template.svg
WORKS=("Balloon Dog" "Pipe" "Urinal")
EDITION_EACH=12
BUILD_DIR="./build"

# The date for the certificates
DATE=$(date +%Y-%M-%d)
echo $DATE

# Ensure the build dir exists
mkdir -p "${BUILD_DIR}"

# For each work
for work in "${WORKS[@]}"
do
    # Make an edition
    for ((i=1; i <= 12; i++))
    do
        nospaces=${work// /}
        filepath="$BUILD_DIR/$nospaces$i.svg"
        pdffilepath="$BUILD_DIR/$nospaces$i.pdf"
        pngfilepath="$BUILD_DIR/$nospaces$i.png"
        echo "$filepath"
        # Copy the template to the build dir
        cp "$SOURCE" "$filepath"
        #inkscape "$SOURCE" --export-plain-svg="$filepath"
        # And fill it out
        perl -i -p -e "s/AAAATITLEAAA/$work/" "$filepath"
        perl -i -p -e "s/XX of YY/$i of $EDITION_EACH/" "$filepath"
        perl -i -p -e "s/XXXX-XX-XX/$DATE/" "$filepath"
        # Then convert it to PDF
        inkscape "$filepath" --export-pdf="$pdffilepath"
        # And convert it to PNG
        inkscape "$filepath" --export-png="$pngfilepath"
    done
done
