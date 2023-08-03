// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

contract SafeMathTesterV8 {
    uint8 public bigNumber = 255; // checked

    function add() public {
        unchecked {bigNumber = bigNumber + 1;}
    }
}
