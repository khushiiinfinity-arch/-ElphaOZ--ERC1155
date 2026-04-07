// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {pikachu} from "../src/pikachu.sol";
 
contract DeployDora is Script {
    function run() external returns (address pina){
        vm.startBroadcast();
        pikachu pina = new pikachu("NASA","NA",400,18);
        vm.stopBroadcast();
        return address(pina);
    }
}