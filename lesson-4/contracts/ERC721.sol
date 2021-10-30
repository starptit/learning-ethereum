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
<<<<<<< HEAD
=======

    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

>>>>>>> fb3facdf346ef637cc4de9963e9a92806e79b99c
    // mapping in solidity creates a hash table of key pair values

    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _ownedTokensCount;

<<<<<<< HEAD
=======
    // Mapping from token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

>>>>>>> fb3facdf346ef637cc4de9963e9a92806e79b99c
    function _exists(uint256 tokenId) internal view returns (bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner != address(0);
    }

<<<<<<< HEAD
    function _mint(address to, uint256 tokenId) internal {
=======
    function _mint(address to, uint256 tokenId) internal virtual {
>>>>>>> fb3facdf346ef637cc4de9963e9a92806e79b99c
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
<<<<<<< HEAD
    function ownerOf(uint256 _tokenId) external view returns (address) {
=======
    function ownerOf(uint256 _tokenId) public view returns (address) {
>>>>>>> fb3facdf346ef637cc4de9963e9a92806e79b99c
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner query for non-existent token");
        return owner;
    }
<<<<<<< HEAD
=======

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(
            _to != address(0),
            "Error - ERC721 transfer to the zero address"
        );
        require(
            ownerOf(_tokenId) == _from,
            "Trying to transfer a token the address"
        );

        _ownedTokensCount[_from] += 1;
        _ownedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);
    }

    // 1. require that the person approving is the owner
    // 2. we are approving an address to a token(tokenId)
    // 3. require that we can't approve sending tokens of the owner to the owner
    // 4. update the map of the approval addresses
    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, "Error - approval to current owner");
        require(
            msg.sender == owner,
            "Current caller is not the owner of the token"
        );
        _tokenApprovals[tokenId] = _to;

        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(_exists(tokenId), "token does not exists");
        address owner = ownerOf(tokenId);
        // return (spender == owner || getApproved(tokenId) == spender);
        return (spender == owner);
    }
>>>>>>> fb3facdf346ef637cc4de9963e9a92806e79b99c
}
