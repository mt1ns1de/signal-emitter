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

    /**
     * @notice Emits a predefined signal to a target address.
     * @param _target The recipient of the encoded wei amount.
     */
    function emitSignal(address payable _target) external {
        require(address(this).balance >= BASED_SIGNAL, "Insufficient fuel");

        // Low-level call to send the exact signal amount
        (bool success, ) = _target.call{value: BASED_SIGNAL}("");
        require(success, "Signal blocked");

        emit SignalSent(_target, BASED_SIGNAL);

        // Attempt to refund remaining dust. 
        // We don't use require here to prevent the "Signal" from failing 
        // if the sender's wallet doesn't have a receive() function.
        uint256 remainder = address(this).balance;
        if (remainder > 0) {
            msg.sender.call{value: remainder}("");
        }
    }
}
