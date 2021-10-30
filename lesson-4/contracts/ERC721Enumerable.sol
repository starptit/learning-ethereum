// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {
    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from tokenId to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokenIndex;

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // 2 things! A. add tokens to the owner
        // B. all tokens to our totalsupply - to all Tokens

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    // add tokens to the _alltokens array and set the position
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. add address and token id to the _ownedTokens
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
        // 2. ownedTokensIndex token Id set to the address of ownedTokens
        // 3. We want to execute the function with minting
        // 4. Bonus is to compile and test
    }

    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "global index is out of bounds");
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
        public
        view
        returns (uint256)
    {
        return _ownedTokens[owner][index];
    }

    // return the total supply of the _allTokens array
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }
}
