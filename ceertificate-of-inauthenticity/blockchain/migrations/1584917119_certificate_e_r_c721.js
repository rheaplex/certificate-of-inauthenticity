const assert = require('assert');
const fs = require('fs');


const CertificateERC721 = artifacts.require("CertificateERC721");


const dirHash= fs.readFileSync('../ipfs-metadata-dir-hash')
      .toString('utf-8')
      .trim();
assert(dirHash != '');


const TOKEN_NAME = "Certificate of Inauthenticity";
const TOKEN_SYMBOL = "COIN";
// Must have trailing slash
const baseURI = `/ipfs/${dirHash}/`;


module.exports = function(deployer) {
  deployer.deploy(CertificateERC721, TOKEN_NAME, TOKEN_SYMBOL, baseURI);
};
