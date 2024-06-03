// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./MultiSigWallet.sol";  // Import the MultiSigWallet contract

contract GNaira is ERC20, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private blacklisted;
    address public governor;
    MultiSigWallet public multiSigWallet;

    event Blacklisted(address indexed account);
    event Unblacklisted(address indexed account);

    modifier onlyGovernor() {
        require(msg.sender == governor, "Only governor can perform this action");
        _;
    }


    modifier notBlacklisted(address account) {
        require(!blacklisted.contains(account), "Blacklisted address");
        _;
    }

    constructor(address[] memory _owners, uint _required) ERC20("G-Naira", "gNGN") Ownable(msg.sender) {
        governor = msg.sender;
        multiSigWallet = new MultiSigWallet(_owners, _required);
    }

    function setGovernor(address _governor) external onlyOwner {
        governor = _governor;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == address(multiSigWallet), "Only MultiSigWallet can mint");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        require(msg.sender == address(multiSigWallet), "Only MultiSigWallet can burn");
        _burn(from, amount);
    }

    function submitMintTransaction(address to, uint256 amount) external onlyGovernor {
        bytes memory data = abi.encodeWithSignature("mint(address,uint256)", to, amount);
        multiSigWallet.submitTransaction(address(this), 0, data);
    }

    function submitBurnTransaction(address from, uint256 amount) external onlyGovernor {
        bytes memory data = abi.encodeWithSignature("burn(address,uint256)", from, amount);
        multiSigWallet.submitTransaction(address(this), 0, data);
    }

    function blacklist(address account) external onlyGovernor {
        require(!blacklisted.contains(account), "Already blacklisted");
        blacklisted.add(account);
        emit Blacklisted(account);
    }

    function unblacklist(address account) external onlyGovernor {
        require(blacklisted.contains(account), "Not blacklisted");
        blacklisted.remove(account);
        emit Unblacklisted(account);
    }

    function isBlacklisted(address account) external view returns (bool) {
        return blacklisted.contains(account);
    }

    function transfer(address recipient, uint256 amount) public override notBlacklisted(msg.sender) notBlacklisted(recipient) returns (bool) {
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override notBlacklisted(sender) notBlacklisted(recipient) returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }
}
