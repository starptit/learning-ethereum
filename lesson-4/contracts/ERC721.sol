// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Building out the minting function:
        a. nft point to an address
        b. keep track of the token ids
        c. keep track of token owner addresses to token ids
        d. keep track of how many tokens an owner address has
        e. create an event that emits a
        transfer log - contract address, where it is being minted to, the id

        Excerise:
        1. write a function called mint that takes two arguments
        an address called to and an integer tokenId
        2. add internal visibility to the signature
        3. set the tokenOwner of the tokenId to the address argument 'to'.
        4. increase the owner token count by 1 each time the function is called

        BONUS
        craete two requirements -
        5. Require that the mint address isn't 0
        6. Require that the token has not already been minted
*/
contract ERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    // mapping in solidity creates a hash table of key pair values

    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownedTokensCount;

    function _exists(uint256 tokenId) internal view returns (bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: minting to the zero address");
        require(!_exists((tokenId)));
        // we aare adding a new address witha token if for minting
        _tokenOwner[tokenId] = to;
        // keep track of each address that is minting and adding one
        _ownedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), "owner query for nonexistent token");
        return _ownedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner query for non-existent token");
        return owner;
    }
}
