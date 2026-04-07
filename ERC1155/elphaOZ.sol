// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract ElphaOZ is ERC1155{

    uint256 public constant ELPHAGi = 0;
    uint256 public constant ELPHAOhi = 1;
    uint256 public constant ELPHAOki = 2;

    mapping(uint256 id => uint256) public totalSupply;
    mapping(uint256 id => uint256) public price;

constructor() ERC1155("https://bafybeidqdsbrtgkts6htyaklwnjgkfxpmv3ffvfat5kpnmhvyv25ckycfe.ipfs.dweb.link"){//this is just a sample uri, you can change it to your own uri

_mint(msg.sender,ELPHAGi,2 ether,"");
price[ELPHAGi] = 2 ether;

}

function mintSingleElpha(address to , uint256 id,uint256  value) public payable {
    require(msg.value == 2 ether * value , "Send the calculated money");
    _mint(to,id,2 ether * value,"");
    totalSupply[id] += 1 ether;
}

function mintBatchOfElphas(address to,uint256[] memory ids,uint256[] memory values) public payable{
    require(ids.length == values.length, "Ids and values length mismatch");

    uint256 totalCost = 0;
    for(uint256 i = 0; i <= ids.length; i++){
        totalCost += price[ids[i]] * values[i];
    }
    require(msg.value == totalCost, "Send the calculated money");
    _mintBatch(to, ids, values, "");

    for(uint256 i = 0; i <= ids.length; i++){
        totalSupply[ids[i]] += values[i];
    }
}
    function safeElphaTransferFrom(address from,address to,uint256 id,uint256 value) public payable  {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not approved to transfer");
        _safeTransferFrom(from, to, id, value,"");
    }

    function safeElphaBatchTransferFrom(address from,address to,uint256[] memory ids,uint256[] memory values) public payable {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not approved to transfer");
        require(ids.length == values.length, "Ids and values length mismatch");
        _safeBatchTransferFrom(from, to, ids, values, "");
        }


     function setApprovalForAllElphas(address operator, bool approved) public {
        require(operator != msg.sender, "Cannot approve self");
        _setApprovalForAll(msg.sender, operator, approved);
     }

     function isApprovedForAllElphas(address account, address operator) public view returns (bool) {
            require(account != address(0), "Account is the zero address");
            require(operator != address(0), "Operator is the zero address");
        
        return isApprovedForAll(account, operator);
     }

     function balanceOfElpha(address account, uint256 id) public view returns (uint256) {
        require(account != address(0), "Account is the zero address");
        return balanceOf(account, id);
     }

     function balanceOfBatchElphas(address[] memory accounts,uint256[] memory ids) public view virtual returns (uint256[] memory){
        return balanceOfBatch(accounts, ids);
     }
}  