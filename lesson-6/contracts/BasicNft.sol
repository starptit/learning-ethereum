// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract BasicNft is ERC721 {
    string public constant TOKEN_URI =

"ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    uint256 private s_tokenCounter;

    event DogMinted(uint256 indexed tokenId);

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        emit DogMinted(s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
    }

    function tokenURI(uint256 tokenId) public pure override returns (string memory) {
        // require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        // return TOKEN_URI;
        string[3] memory parts;

        parts[
            0
        ] = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 300px; }</style><rect width='100%' height='100%' fill='brown' /><text x='100' y='260' class='base'>";

        parts[1] = Strings.toString(tokenId);

        parts[2] = "</text></svg>";

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name":"Badge #',
                        Strings.toString(tokenId),
                        '","description":"Badge NFT with on-chain SVG image.",',
                        '"image": "data:image/svg+xml;base64,',
                        // Base64.encode(bytes(output)),
                        Base64.encode(
                            bytes(
                                abi.encodePacked(parts[0], parts[1], parts[2])
                            )
                        ),
                        '"}'
                    )
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}