// components/ReadNFTMarket.tsx
import React from "react";
import { useEffect, useState } from "react";
import { useWeb3React } from "@web3-react/core";
import { Web3Provider } from "@ethersproject/providers";
import { Contract } from "@ethersproject/contracts";
import { Grid, GridItem, Box, Text, Button } from "@chakra-ui/react";
import { BigNumber, ethers } from "ethers";
import useSWR from "swr";
import { addressNFTContract, addressMarketContract } from "../projectsetting";
import CardERC721 from "./CardERC721";

interface Props {
  option: number;
}

export default function ReadNFTMarket(props: Props) {
  const abiJSON = require("abi/NftMarketplace-2.json");
  const abi = abiJSON.abi;
  const [items, setItems] = useState<[]>();

  const { account, active, library } = useWeb3React<Web3Provider>();

  useEffect(() => {
    if (!active) setItems(undefined);
    if (!(active && account && library)) return;

    const market: Contract = new Contract(addressMarketContract, abi, library);

    library.getCode(addressMarketContract).then((result: string) => {
      //check whether it is a contract
      if (result === "0x") return;
      0;
      market
        .getListing("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0", 0)
        .then((items: any) => {
          // console.log("--------");

          // console.log(items);
          setItems(items);
        });
    });

    //called only when changed to active
  }, [active, account]);

  async function buyInNFTMarket(event: React.FormEvent, itemId: BigNumber) {
    event.preventDefault();

    if (!(active && account && library)) return;

    //TODO check whether item is available beforehand

    const market: Contract = new Contract(
      addressMarketContract,
      abi,
      library.getSigner()
    );
    const auctionPrice = ethers.utils.parseUnits("1", "ether");

    console.error(market);
    market
      .createMarketSale(addressNFTContract, itemId, { value: auctionPrice })
      .catch("error", console.error);
  }

  const state = ["On Sale", "Sold", "Inactive"];

  return (
    <Grid templateColumns="repeat(3, 1fr)" gap={0} w="100%">
      {items ? (
        items.length == 0 ? (
          <Box>no item</Box>
        ) : (
          items.map((item: any) => {
            console.log(item);

            return (
              <GridItem key={item.id}>
                <CardERC721
                  addressContract={item.nftContract}
                  tokenId={item.tokenId}
                ></CardERC721>
                <Text fontSize="sm" px={5} pb={1}>
                  {" "}
                  {state[item.state]}{" "}
                </Text>
                {(item.seller == account &&
                  item.buyer == ethers.constants.AddressZero) ||
                item.buyer == account ? (
                  <Text fontSize="sm" px={5} pb={1}>
                    {" "}
                    owned by you{" "}
                  </Text>
                ) : (
                  <Text></Text>
                )}
                <Box>
                  {item.seller != account && item.state == 0 ? (
                    <Button
                      width={220}
                      type="submit"
                      onClick={(e) => buyInNFTMarket(e, item.id)}
                    >
                      Buy this!
                    </Button>
                  ) : (
                    <Text></Text>
                  )}
                </Box>
              </GridItem>
            );
          })
        )
      ) : (
        <Box></Box>
      )}
    </Grid>
  );
}
