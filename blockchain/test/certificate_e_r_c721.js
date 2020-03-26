var CertificateERC721 = artifacts.require("CertificateERC721");

contract("CertificateERC721", function(accounts) {
  it("should assert true", function(done) {
    var certificate_e_r_c721 = CertificateERC721.deployed();
    assert.isTrue(true);
    done();
  });
});
