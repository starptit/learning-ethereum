const { ethers } = require("hardhat")

const PRICE = ethers.utils.parseEther("0.1")


/*
* Deploy the contracts using our deployer account (Hardhat test account with index 0).
* Mint and list 3 NFTs with an “owner” account (Hardhat test account with index 1).
* Buy NFT #0 with a buyer account (Hardhat test account with index 2).
* Update NFT #1’s price and check the listing.
* Cancel NFT #2 and check that it’s not longer listed.
* Check that marketplace has correctly recorded the owner/seller’s proceeds from the sale of NFT #0 .
*/

async function mintAndList() {
    const accounts = await ethers.getSigners()
    const [deployer, owner, buyer1] = accounts

    const IDENTITIES = {
        [deployer.address]: "DEPLOYER",
        [owner.address]: "OWNER",
        [buyer1.address]: "BUYER_1",
    }

    const nftMarketplaceContract = await ethers.getContract("NftMarketplace")
    const basicNftContract = await ethers.getContract("BasicNft")

    console.log(`Minting NFT for ${owner.address}`)
    const mintTx = await basicNftContract.connect(owner).mintNft()
    const mintTxReceipt = await mintTx.wait(1)
    const tokenId = mintTxReceipt.events[0].args.tokenId

    console.log("Approving Marketplace as operator of NFT...")
    const approvalTx = await basicNftContract
        .connect(owner)
        .approve(nftMarketplaceContract.address, tokenId)
    await approvalTx.wait(1)

    console.log("Listing NFT...")
    const tx = await nftMarketplaceContract
        .connect(owner)
        .listItem(basicNftContract.address, tokenId, PRICE)
    await tx.wait(1)
    console.log("NFT Listed with token ID: ", tokenId.toString())

    const mintedBy = await basicNftContract.ownerOf(tokenId)
    console.log(
        `NFT with ID ${tokenId} minted and listed by owner ${mintedBy} with identity ${IDENTITIES[mintedBy]}.`
    )
}

mintAndList()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })