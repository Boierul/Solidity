// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {ForgeSimpleStorage} from "../src/ForgeSimpleStorage.sol";

contract DeploySimpleStorage is Script {
    function run() external returns (ForgeSimpleStorage) {
        // VM is a global variable that is available in all scripts (only in Forge/Foundry)
        vm.startBroadcast();
        // Create a new ForgeSimpleStorage contract
        ForgeSimpleStorage storageContract = new ForgeSimpleStorage();
        vm.stopBroadcast();
        return storageContract;
    }
}
