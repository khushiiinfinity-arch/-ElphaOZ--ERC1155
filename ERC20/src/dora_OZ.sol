// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//Making dora {Token}
//Can bo deployed through Remix 
//Anvil do not have an Token detection 
contract dora is ERC20 { 
        constructor() ERC20("Nobita", "Nob") { // name and symbol of the token, could be anything 
        _mint(msg.sender, 500 * 10 ** decimals()); 
        }         
}