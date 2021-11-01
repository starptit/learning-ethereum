import React, { Component } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import KryptoBird from "../abis/KryptoBird.json";

class App extends Component {
  async loadWeb3() {
    const provider = await detectEthereumProvider;

    if (provider) {
      console.log("ethereum wallet is connected");
      window.Web3 = new Web3(provider);
    } else {
      console.log("no ethereum wallet detected");
    }
  }

  render() {
    return (
      <div>
        <h1>NFT Marketplace</h1>
      </div>
    );
  }
}

export default App;
