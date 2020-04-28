#!/bin/bash

IMAGE_DIR_HASH_FILE="ipfs-certificate-dir-hash"
IMAGE_SRC_DIR="./metadata/images/"

if [ -f "${IMAGE_DIR_HASH_FILE}" ]; then
    echo "ipfs-image-dir-hash file already exists, not adding files to ipfs."
    exit 1
fi

# Deploy the image files

ipfs add -Q -w "${IMAGE_SRC_DIR}/"*.png > "${IMAGE_DIR_HASH_FILE}"
