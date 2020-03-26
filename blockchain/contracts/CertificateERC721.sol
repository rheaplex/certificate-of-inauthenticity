pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

contract CertificateERC721
is ERC721Full("Certificate of Inauthenticity", "CINAUTH") {
  constructor() public {
      // Mint 3 x 11 tokens
      for(uint256 i = 1; i <= 33; i++) {
          _mint(msg.sender, i);
      }
  }
}
