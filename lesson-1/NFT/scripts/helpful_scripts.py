from brownie import accounts, network, config, LinkToken, MockV3Aggregator, MockOracle, VRFCoordinatorMock, Contract

LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["hardhat", "development", "ganache", "mainnet-fork", "binance-fork", "matic-fork"]
OPENSEA_URL = "https://testnets.opensea.io/assets/{}/{}"
contract_to_mock = {
    "link_token": LinkToken,
    "eth_usd_price_feed": MockV3Aggregator,
    "vrf_coordinator": VRFCoordinatorMock,
    "oracle": MockOracle,
}

def get_account(index=None, id=None):
    print(config["wallets"]["from_key"])
    if index:
        return accounts[index]
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        return accounts[0]
    if id:
        return accounts.load(id)
    # if network.show_active() in config["networks"]:
    return accounts.add(config["wallets"]["from_key"])
    # return Nonesdffsdfsd

def get_contract(contract_name):
    contract_type = contract_to_mock[contract_name]
    if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        if len(contract_type) <= 0:
            deploy_mocks()
        contract = contract_type[-1]
    else:
        contract_address = config["networks"][network.show_active()][contract_name]
        contract = Contract.from_abi(
            contract_type.name, contract_address, contract_type.abi
        )
    return contract

def deploy_mocks():
    print(f"The active network is {network.show_active()}")
    print("Deploying mocks...")
    account = get_account()
    print("Deploying Mock LinkToken...")
    link_token = LinkToken.deploy({"from": account})
    print(f"Deploying Mock VRF Coordinator...")
    vrf_coordinator = VRFCoordinatorMock.deploy(link_token.address, {"from": account})
    print(f"VRFCoordinator deployed to {vrf_coordinator.address}")

# def get_contract(contract_name):
#     """If you want to use this function, go to the brownie config and add a new entry for
#     the contract that you want to be able to 'get'. Then add an entry in the in the variable 'contract_to_mock'.
#     You'll see examples like the 'link_token'.
#         This script will then either:
#             - Get a address from the config
#             - Or deploy a mock to use for a network that doesn't have it
#         Args:
#             contract_name (string): This is the name that is refered to in the
#             brownie config and 'contract_to_mock' variable.
#         Returns:
#             brownie.network.contract.ProjectContract: The most recently deployed
#             Contract of the type specificed by the dictonary. This could be either
#             a mock or the 'real' contract on a live network.
#     """
#     contract_type = contract_to_mock[contract_name]
#     if network.show_active() in NON_FORKED_LOCAL_BLOCKCHAIN_ENVIRONMENTS:
#         if len(contract_type) <= 0:
#             deploy_mocks()
#         contract = contract_type[-1]
#     else:
#         try:
#             contract_address = config["networks"][network.show_active()][contract_name]
#             contract = Contract.from_abi(
#                 contract_type._name, contract_address, contract_type.abi
#             )
#         except KeyError:
#             print(
#                 f"{network.show_active()} address not found, perhaps you should add it to the config or deploy mocks?"
#             )
#             print(
#                 f"brownie run scripts/deploy_mocks.py --network {network.show_active()}"
#             )
#     return contract

