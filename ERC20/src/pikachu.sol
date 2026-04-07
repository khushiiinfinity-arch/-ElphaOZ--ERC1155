// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract pikachu {
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private approval;

    string public name;
    string public symbol;
    uint256  totalSupply;
    uint256  decimals;


    event Transfer(address indexed From, address indexed To, uint256 value);

    event approve(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor(
        string memory Tokenname,
        string memory Tokensym,
        uint256 TokentotalSupply,
        uint256 decimal
    ) {
        name = Tokenname;
        symbol = Tokensym;
        totalSupply = TokentotalSupply * 10 ** decimal;
        decimals = decimal;
        balances[msg.sender] = totalSupply;
     // emit Transfer(address(0), msg.sender, totalSupply);

        }

    function nameOfToken() public view returns (string memory) {
        //return address(this);
        return name;
    }

    function totalSupplyOfToken() public view returns (uint256) {
        return totalSupply;
    }

    function decimalsOfToken() public view returns (uint256) {
        return decimals;
    }

    function symbolOfToken() public view returns (string memory) {
        return symbol;
    }

    function balanceOf(address addressOfOwner) public view returns (uint256 balance) {
        return balances[addressOfOwner];
    }

    function transfer(
        address to,
        uint256 amount
    ) public payable returns (bool success) {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender,to,amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool success) {
        require(balances[from] <= value);
        balances[from] -= value;
        balances[to] += value;
        emit Transfer(from,to,value);
        return true;
    }

    function approveofSender(
        address spender,
        uint256 value
    ) public returns (bool success) {
        approval[msg.sender][spender] = value;
     //   balances[spender] <= value ;
        emit approve(msg.sender,spender,value);
        return true;
    }

    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        return  approval[owner][spender];
    }

}