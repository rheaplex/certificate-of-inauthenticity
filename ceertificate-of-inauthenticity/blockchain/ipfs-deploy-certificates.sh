#!/bin/bash

source ./config.sh

if [ -f "${IMAGE_DIR_HASH_FILE}" ]; then
    echo "ipfs-image-dir-hash file already exists, not adding files to ipfs."
    exit 1
fi

# Deploy the image files

ipfs add -Q -w "${CERTIFICATES_DIR}/"*.png > "${CERTIFICATES_DIR_HASH_FILE}"
