pragma solidity ^0.5.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Metadata.sol";
import "@openzeppelin/contracts/introspection/ERC165.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";


// We don't use the ERC721Metadata implementation as we don't need the storage
// and functions it adds.

contract CertificateERC721
is ERC165, ERC721, ERC721Enumerable, IERC721Metadata, Ownable
() {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Base URI
    string private _baseURI;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     *
     */
    constructor (
        string memory name,
        string memory symbol,
        string memory baseURI
    ) public {
        _name = name;
        _symbol = symbol;
        setBaseURI(baseURI);

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);

        // Mint 3 x 11 tokens
        for(uint256 i = 1; i <= 33; i++) {
            _mint(msg.sender, i);
        }
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the URI for a given token ID. May return an empty string.
     *
     * If the token's URI is non-empty and a base URI was set (via
     * {_setBaseURI}), it will be added to the token ID's URI as a prefix.
     *
     * Reverts if the token ID does not exist.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        // abi.encodePacked is being used to concatenate strings
        return string(abi.encodePacked(_baseURI, uint2str(tokenId)));
    }

    /**
     * @dev Function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI}.
     *
     * Ideally the base would be immutable but I need time to migrate to ipfs.
     *
     */
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseURI = baseURI;
    }


    /**
    * @dev Returns the base URI set via {_setBaseURI}. This will be
    * automatically added as a preffix in {tokenURI} to each token's URI, when
    * they are non-empty.
    *
    */
    function baseURI() external view returns (string memory) {
        return _baseURI;
    }

    /**
     * @dev Returns i formatted as a base 10 string.
     * Via: https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol
     *
     */
    function uint2str(uint i) internal pure returns (string memory) {
        if (i == 0) return "0";
        uint j = i;
        uint len;
        while (j != 0){
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (i != 0){
            bstr[k--] = byte(48 + uint8(i % 10));
            i /= 10;
        }
        return string(bstr);
    }
}
