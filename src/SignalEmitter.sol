// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title Signal Emitter
 * @notice Transmission of ASCII messages via native ETH value steganography.
 * @dev High-signal, low-cost communication using the 'value' field as data.
 */
contract SignalEmitter {
    // "BASED" encoded as 0x4241534544
    uint256 public constant BASED_SIGNAL = 284558263620;

    event SignalSent(address indexed target, uint256 signal);

    receive() external payable {}

    function emitSignal(address payable _target) external {
        require(address(this).balance >= BASED_SIGNAL, "Insufficient fuel");

        (bool success, ) = _target.call{value: BASED_SIGNAL}("");
        require(success, "Signal blocked");

        emit SignalSent(_target, BASED_SIGNAL);

        uint256 remainder = address(this).balance;
        if (remainder > 0) {
            (bool refundSuccess, ) = msg.sender.call{value: remainder}("");
            require(refundSuccess, "Refund failed");
        }
    }
}
