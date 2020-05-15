#!/bin/bash

source ./config.sh

if [ -f "${IMAGE_DIR_HASH_FILE}" ]; then
    echo "${IMAGE_DIR_HASH_FILE} file already exists, not adding files to ipfs."
    exit 1
fi

# Deploy the image files

ipfs add -Q -w "${IMAGE_DIR}/"*.png > "${METADATA_DIR_HASH_FILE}"
