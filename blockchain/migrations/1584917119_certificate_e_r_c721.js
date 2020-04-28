const CertificateERC721 = artifacts.require("CertificateERC721");

module.exports = function(deployer) {
  deployer.deploy(CertificateERC721);
};
