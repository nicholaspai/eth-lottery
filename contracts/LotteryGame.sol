pragma solidity ^0.4.24;

import "zos-lib/contracts/Initializable.sol";

// Generates an 8-bit winning bitstring
contract LotteryGame is Initializable {

    uint256 public numRounds; // Number of rounds
    uint256 public numParticipants; // Number of participants
    byte public winner; // Make this private for production!
    string public pendingWinner; // Currently revealed bitstring

    // Events

    function initialize() initializer public {
        numRounds = 4; 
        numParticipants = 256; // 2^8 bits = 256 participants
        pendingWinner = "";

        winner = toByte(uint8(0));
    }

    function toByte(uint8 _num) internal pure returns (byte _ret) {
        return byte(_num);
    }

    // Generate winning 8-bit bitstring
    function generateWinner() public {
        
        uint8 randomNumber = uint8(123);
        winner = toByte(randomNumber);
    }

    //TODO:
    // Add following methods
    // Int to bit string
    // Generate ith bit
    // Random number generator https://medium.com/@promentol/lottery-smart-contract-can-we-generate-random-numbers-in-solidity-4f586a152b27

    // Make certain functions onlyOwner!
}