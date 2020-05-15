const fs = require('fs');
const truffleAssert = require('truffle-assertions');


const CertificateERC721 = artifacts.require("CertificateERC721");

const dirHash= fs.readFileSync('ipfs-metadata-dir-hash')
      .toString('utf-8')
      .trim();
assert(dirHash != '');

const NUM_TOKENS = 33;
const TOKEN_NAME = "Certificate of Inauthenticity";
const TOKEN_SYMBOL = "COIN";
// Must have trailing slash
const baseURI = `/ipfs/${dirHash}/`;


contract("CertificateERC721", accounts => {
  let token;

  before(async () => {
    token = await CertificateERC721.deployed();
  });

  it("should be configured correctly on deployment", async () => {
    assert.equal(await token.name(), TOKEN_NAME);
    assert.equal(await token.symbol(), TOKEN_SYMBOL);
    assert.equal(await token.baseURI(), baseURI);
    assert.equal(await token.balanceOf(accounts[0]), NUM_TOKENS);
  });

  it("should return correct token URIs", async () => {
    for (let i = 1; i < NUM_TOKENS + 1; i++) {
      assert.equal(
        await token.tokenURI(i),
        `${baseURI}${i}`
      );
    }
  });

  it("should transfer tokens from owner", async () => {
    await token.transferFrom(accounts[0], accounts[1], 1);
    assert.equal(await token.ownerOf(1), accounts[1]);
    assert.equal(await token.balanceOf(accounts[1]), 1);
  });

  it("should allow owner to setBaseURI()", async () => {
    await token.setBaseURI('aaaa');
    assert.equal(await token.baseURI(), 'aaaa');
  });

  it("should not allow non-owner to setBaseURI()", async () => {
    await truffleAssert.fails(
      token.setBaseURI('aaaa', {from: accounts[1]}),
      truffleAssert.ErrorType.REVERT,
      'caller is not the owner'
    );
  });

  
  // And if it does that it should be OK. :-)
});
