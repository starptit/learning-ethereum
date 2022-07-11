// src/pages/index.tsx
import type { NextPage } from "next";
import Head from "next/head";
import NextLink from "next/link";
import {
  VStack,
  HStack,
  Heading,
  Box,
  LinkOverlay,
  LinkBox,
} from "@chakra-ui/layout";
import { Text, Button } from "@chakra-ui/react";
import ConnectMetamask from "components/ConnectMetaMask";
import ETHBalance from "components/ETHBalance";
import ETHBalanceSWR from "components/ETHBalanceSWR";
import ReadERC20 from "components/ReadERC20";
import TransferERC20 from "components/TransferERC20";
import ReadNFTMarket from "components/ReadNFTMarket";
// import ReadERC72

const addressContract = "0xfEe9fd24F503309Ea61DAeb127eeFC36ac65f602";

const Home: NextPage = () => {
  return (
    <>
      <Head>
        <title>My DAPP</title>
      </Head>

      <Heading as="h3" my={4}>
        NFT Marketplace
      </Heading>
      <HStack my={6} py={2} px={3} backgroundColor="gray.100">
        <Box px={3}>
          <Text fontSize="sm">Prepare</Text>
        </Box>
        <Box px={3}>
          <Text fontSize="sm">1-6 by Account#0, 1- Account1, 2- Account#2</Text>
          <Text fontSize="sm">7-9 by Account#1, 7,8 - Account#0</Text>
          <Text fontSize="sm">In market: 3,4,5,9 (6 delist by Account#0)</Text>
        </Box>
        <Box px={3}>
          <Text fontSize="sm">Account#0:Buy 7,8, List:1-5( 6 delisted) </Text>
          <Text fontSize="sm">Account#1:Buy 1, List:7-9 </Text>
          <Text fontSize="sm">Account#2:Buy 2, List:n/a </Text>
        </Box>
      </HStack>

      <ConnectMetamask />

      <VStack>
        <Box mb={0} p={4} w="100%" borderWidth="1px" borderRadius="lg">
          <Heading my={4} fontSize="xl">
            NFT Market - all
          </Heading>
          <ReadNFTMarket option={0} />
        </Box>

        <Box mb={0} p={4} w="100%" borderWidth="1px" borderRadius="lg">
          <Heading my={4} fontSize="xl">
            NFT Market - my bought
          </Heading>
          <ReadNFTMarket option={1} />
        </Box>

        <Box mb={0} p={4} w="100%" borderWidth="1px" borderRadius="lg">
          <Heading my={4} fontSize="xl">
            NFT Market - my created
          </Heading>
          <ReadNFTMarket option={2} />
        </Box>

        {/* <Box mb={0} p={4} w="100%" borderWidth="1px" borderRadius="lg">
          <Heading my={4} fontSize="xl">
            ETH Balance <b>using SWR</b>
          </Heading>
          <ETHBalanceSWR />
        </Box> */}

        {/* <Box my={4} p={4} w="100%" borderWidth="1px" borderRadius="lg">
          <Heading my={4} fontSize="xl">
            BadgeToken: ERC721 Smart Contract Info
          </Heading>
          <ReadERC721 addressContract={addressNFTContract} />
        </Box> */}
      </VStack>
    </>
  );
};

export default Home;
