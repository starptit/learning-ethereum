from scripts.helpful_scripts import get_account, OPENSEA_URL, get_contract, fund_with_link
from brownie import AdvancedCollectible, network, config


# sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"
# OPENSEA_URL = "https://testnets.opensea.io/assets/{}/{}"

def deploy_and_create():
    account = get_account()

    advanced_collectible = AdvancedCollectible.deploy(
        get_contract("vrf_coordinator"),
        get_contract("link_token"),
        config["networks"][network.show_active()]["keyhash"],
        config["networks"][network.show_active()]["fee"],
        {"from": account}
    )
    fund_with_link(advanced_collectible.address)
    creating_tx = advanced_collectible.createCollectible({"from": account})
    creating_tx.wait(1)
    print("New token has been created!")



    # tx = simple_collectible.createCollectible(sample_token_uri, {"from": account})
    # tx.wait(1)
    # print(
    #     f"Awesome, you can view your NFT at {OPENSEA_URL.format(simple_collectible.address,simple_collectible.tokenCounter() - 1)}"
    #     )
    # print("PLease wait up to 20 minutes, and hit the refresh metadata button")
    # return simple_collectible


def main():
    deploy_and_create()