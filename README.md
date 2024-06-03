# GNaira and MultiSigWallet Smart Contracts

This repository contains the smart contract code for `GNaira`, an ERC20 token, and `MultiSigWallet`, a multi-signature wallet designed to securely manage the minting and burning of `GNaira` tokens.

## Table of Contents

- [Overview](#overview)
- [Contracts](#contracts)
  - [GNaira](#gnaira)
  - [MultiSigWallet](#multisigwallet)
- [Deployment](#deployment)
  - [Prerequisites](#prerequisites)
  - [Steps](#steps)
- [Interaction](#interaction)
  - [Minting Tokens](#minting-tokens)
  - [Burning Tokens](#burning-tokens)
  - [Blacklisting and Unblacklisting](#blacklisting-and-unblacklisting)
- [Contributing](#contributing)
- [License](#license)

## Overview

The `GNaira` smart contract is an ERC20 token with additional functionality for blacklisting addresses and controlled minting and burning via a multi-signature wallet (`MultiSigWallet`). The `MultiSigWallet` contract allows multiple owners to manage transactions, ensuring that no single entity has full control over the token's critical operations.

## Contracts

### GNaira

`GNaira` is an ERC20 token contract with the following features:
- Minting and burning tokens via a multi-signature wallet.
- Blacklisting addresses to prevent transfers.
- Ownership management to change the governor.

### MultiSigWallet

`MultiSigWallet` is a multi-signature wallet that requires a predefined number of confirmations from owners to execute a transaction. It ensures secure and decentralized management of the `GNaira` token.

## Deployment

### Prerequisites

- Solidity compiler (`^0.8.0`)
- [Remix IDE](https://remix.ethereum.org/)
- Ethereum wallet (e.g., MetaMask)

### Steps

1. **Deploy `MultiSigWallet`**:
   - Open Remix IDE.
   - Create a new file `MultiSigWallet.sol`.
   - Paste the `MultiSigWallet` contract code.
   - Compile the contract.
   - Deploy the contract with constructor parameters:
     - `owners`: An array of owner addresses (e.g., `["0xOwner1", "0xOwner2"]`).
     - `required`: Number of required confirmations (e.g., `2`).

2. **Deploy `GNaira`**:
   - Create a new file `GNaira.sol`.
   - Paste the `GNaira` contract code.
   - Ensure you import `MultiSigWallet.sol`.
   - Compile the contract.
   - Deploy the contract with constructor parameters:
     - `owners`: The same array of owner addresses used in `MultiSigWallet`.
     - `required`: The same number of required confirmations.

## Interaction

### Minting Tokens

1. **Submit a Mint Transaction**:
   - Select the deployed `GNaira` contract in Remix.
   - Call `submitMintTransaction` with parameters:
     - `to`: Address to receive the minted tokens.
     - `amount`: Number of tokens to mint.

2. **Confirm the Mint Transaction**:
   - Select the deployed `MultiSigWallet` contract in Remix.
   - Switch to an owner account.
   - Call `confirmTransaction` with the transaction ID (e.g., `0`).

### Burning Tokens

1. **Submit a Burn Transaction**:
   - Select the deployed `GNaira` contract in Remix.
   - Call `submitBurnTransaction` with parameters:
     - `from`: Address from which to burn the tokens.
     - `amount`: Number of tokens to burn.

2. **Confirm the Burn Transaction**:
   - Select the deployed `MultiSigWallet` contract in Remix.
   - Switch to an owner account.
   - Call `confirmTransaction` with the transaction ID.

### Blacklisting and Unblacklisting

- **Blacklist an Address**:
  - Call `blacklist` on the `GNaira` contract with the address to be blacklisted.

- **Unblacklist an Address**:
  - Call `unblacklist` on the `GNaira` contract with the address to be unblacklisted.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This README provides a comprehensive guide to deploying and interacting with the `GNaira` and `MultiSigWallet` smart contracts. Ensure you replace any placeholder addresses with actual Ethereum addresses before deployment.
