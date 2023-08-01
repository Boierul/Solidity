// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

// Using Inheritance to add functionality to a contract
contract AddFiveStorage is SimpleStorage {
    // Function to add 5 to a number in a SimpleStorage contract
    function store(uint256 _favoriteNumber) public override {
        myFavoriteNumber = _favoriteNumber + 5;
    }
}