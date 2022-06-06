# msa

Welcome to your new msa project and to the internet computer development community. By default, creating a new project adds this README and some template files to your project directory. You can edit these template files to customize your project and to include your own code to speed up the development cycle.

To get started, you might want to explore the project directory structure and the default configuration file. Working with this project in your development environment will not affect any production deployment or identity tokens.

To learn more before you start working with msa, see the following documentation available online:

- [Quick Start](https://smartcontracts.org/docs/quickstart/quickstart-intro.html)
- [SDK Developer Tools](https://smartcontracts.org/docs/developers-guide/sdk-guide.html)
- [Rust Canister Devlopment Guide](https://smartcontracts.org/docs/rust-guide/rust-intro.html)
- [ic-cdk](https://docs.rs/ic-cdk)
- [ic-cdk-macros](https://docs.rs/ic-cdk-macros)
- [Candid Introduction](https://smartcontracts.org/docs/candid-guide/candid-intro.html)
- [JavaScript API Reference](https://erxue-5aaaa-aaaab-qaagq-cai.raw.ic0.app)

If you want to start working on your project right away, you might want to try the following commands:

```bash
cd msa/
dfx help
dfx config --help
```

## Running the project locally

If you want to test your project locally, you can use the following commands:

```bash
# Deploys your canisters to the replica and generates your candid interface
# 1st argument - Pass principal of plug wallet in argument through which you want to mint NFT tokens (players)
# 2nd argument - Pass principal of plug wallet in argument through which you want to buy NFT tokens (players)
. deploy.sh <PRINCIAPL_ID> <PRINCIPAL_ID>
```

Once the job completes, your application will be available at `http://localhost:8000?canisterId={asset_canister_id}`.


## Deploy canister on Mainnet (Internet Computer)

If you want to deploy your project on Mainnet, you can use the following commands:

```bash
# Deploys your canisters to the replica and generates your candid interface
# Pass principal of plug wallet in argument through which you want to buy NFT tokens (players)
. deploy_prod.sh <PRINCIPAL_ID>
```