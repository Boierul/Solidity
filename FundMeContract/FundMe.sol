// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Docs at: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

// Custom error
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    // Immutable owner of the contract
    address public immutable i_owner;
    // Minimum amount of USD that can be funded
    uint256 public MINIMUM_USD = 5 * 10 ** 18 // 5e18;

    // Deploy contract price
    // 794593 gas * 26000000000 gasPrice (varies cause of the network requests) = 20.000.000.000.000.000 WEI or $36.89
    // Call function price
    // 2407  gas * 36000000000 gasPrice = 86.652.000.000.000 WEI or $0.16

    // Array of addresses of donors
    address[] public funders;
    // Dictionary (hash table) that maps donor addresses to amounts
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more than 5USD");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // Itterate over funders array and reset their values to 0
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // Reset funders array
        funders = new address[](0);

        // How to withdraw the funds to account that called the function?
        // Docs: https://solidity-by-example.org/sending-ether/
        // -> 1. Transfer, 2. Send, 3. Call

        /* Transfer
        payable(msg.sender).transfer(address(this).balance);
        */

        /* Send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");
        */

        /* Call - Recommended way to send/transfer ETH/Native tokens of the Blockchain */
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    modifier onlyOwner() {
    // More gas efficient way, and recommended way since Solidity 0.8.4
        if (msg.sender != i_owner) {revert NotOwner();}
        _;

        //  Otherwise use this line at the top of the function:
        //        require(msg.sender == i_owner, "You are not the owner of the contract");
    }

    // Special function that is called when no other function matches
    fallback() external payable {
        fund();
    }

    // Special function that is called when accidentially sending ETH to the contract
    receive() external payable {
        fund();
    }
}