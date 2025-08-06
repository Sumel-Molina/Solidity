// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Index {
    //投票系统
    //投票系统的核心合约
    address public owner;
    mapping (address => uint) public NameToVotes;
    constructor() {
        owner = msg.sender;
    }
    function bossAdd(address candidate) public {
        
    }
    function peopelAdd(address button) public{

    }
}