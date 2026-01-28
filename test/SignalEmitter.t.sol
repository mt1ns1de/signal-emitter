// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/SignalEmitter.sol";

contract SignalEmitterTest is Test {
    SignalEmitter emitter;
    address constant TARGET = address(0x1337);

    function setUp() public {
        emitter = new SignalEmitter();
    }

    function test_SignalIntegrity() public {
        vm.deal(address(emitter), 1 ether);
        emitter.emitSignal(payable(TARGET));
        assertEq(TARGET.balance, 284558263620);
    }
}
