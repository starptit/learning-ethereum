// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

contract Kryptobird is ERC721Connector {
    // array to store our nfts
    string[] public kryptoBirdz;
    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        // uint256 _id = kryptoBirdz.push(_kryptoBird);

        require(
            !_kryptoBirdzExists[_kryptoBird],
            "Error - kryptoBid already exists"
        );

        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    }

    constructor() ERC721Connector("Kryptobird", "KBIRDZ") {}
}
