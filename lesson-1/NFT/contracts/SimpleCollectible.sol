
// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"


contract SimpleCollectible is ERC721 {
    uint256 public tokenCounter;

    constructor () public ERC721 ("SwiftyVN", "Swifty") {
        tokenCounter = 0;    
    }

    function createCollectible(string memory tokenURI) public returns (uint256) {
        uint256 newTokenId = tokenCounter;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter = tokenCounter + 1;
        return newTokenId;
    }

}