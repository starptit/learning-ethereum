// src/pages/samplenft.tsx
import type { NextPage } from "next";
import Head from "next/head";
import { VStack, Heading } from "@chakra-ui/layout";
import ConnectMetamask from "components/ConnectMetaMask";
import CardERC721 from "components/CardERC721";
import { BigNumber } from "ethers";

const nftAddress = "0xE57D3907702F84072EF95678E1A4d55658f34866"; // BADGE TOKEN address

const tokenId = BigNumber.from(1);
const SampleNFTPage: NextPage = () => {
  return (
    <>
      <Head>
        <title>My DAPP</title>
      </Head>

      <Heading as="h3" my={4}>
        NFT Marketplace
      </Heading>

      <ConnectMetamask />

      <VStack>
        <CardERC721 addressContract={nftAddress} tokenId={tokenId}></CardERC721>
      </VStack>
    </>
  );
};

export default SampleNFTPage;
