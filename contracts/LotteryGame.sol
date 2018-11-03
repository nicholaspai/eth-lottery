pragma solidity ^0.4.24;

import "zos-lib/contracts/Initializable.sol";

// Generates an 8-bit winning bitstring
contract LotteryGame is Initializable {

    uint256 public numRounds; // Number of rounds
    uint256 public numParticipants; // Number of participants
    byte public winner; // Make this private for production!
    string public pendingWinner; // Currently revealed bitstring

    // Events
    event WinnerGenerated(byte winner);

    function initialize() initializer public {
        numRounds = 4; 
        numParticipants = 256; // 2^8 bits = 256 participants
        pendingWinner = "";

        // Generate winning 8-bit bitstring
        uint8 randomNumber = uint8(200);
        winner = toByte(randomNumber);
        emit WinnerGenerated(winner);
    }

    function toByte(uint8 _num) internal pure returns (byte _ret) {
        return byte(_num);
    }

}