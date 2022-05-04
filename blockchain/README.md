# Oh For A Makefile

## Https Deploy

    bash generate-certificates.sh
    bash generate-metadata-https.sh

## IPFS Deploy

If ipfs-certificate-dir-hash and ipfs-metadata-dir-hash are present you should probably stop. If you do need to continue, delete them otherwise the ipfs deployment scripts won't work.

    bash generate-certificates.sh
    bash ipfs-deploy-certificates.sh
    bash generate-metadata-ipfs.sh
    bash ipfs-deploy-metadata.sh

## Updating The Base URI If This Is After Initial Deployment

Use setBaseURI() on the CertificateERC721 contract

For IPFS the URI is:

    ipfs://<content of ipfs-metadata-dir-hash>/ .

For HTTPS the URI is:

    https://show.robmyers.org/certificate-of-inauthenticity/metadata/

(unless you wish to move it).
