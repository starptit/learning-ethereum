// src/pages/samplenft.tsx
import type { NextPage } from "next";
import Head from "next/head";
import { VStack, Heading } from "@chakra-ui/layout";
import ConnectMetamask from "components/ConnectMetaMask";
import CardERC721 from "components/CardERC721";
import { BigNumber } from "ethers";

const nftAddress = "0xfEe9fd24F503309Ea61DAeb127eeFC36ac65f602";
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
