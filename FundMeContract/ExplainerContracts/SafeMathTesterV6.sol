// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

contract SafeMathTesterV6 {
    uint8 public bigNumber = 255; // unchecked

    function add() public {
        bigNumber = bigNumber + 1;
    }
}
