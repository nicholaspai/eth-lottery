pragma solidity ^0.4.24;

import "zos-lib/contracts/Initializable.sol";

// Generates an 8-bit winning bitstring
// TODO: READ THIS: https://medium.com/coinmonks/lottery-as-a-smart-contract-the-execution-904a26201338
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
    // Checkout: https://gist.github.com/anonymous/06a86a039f01dc15fd14
    // https://www.reddit.com/r/ethereum/comments/442z66/how_to_generate_a_number_between_110_in_solidity/
    function generateWinner() public {
        
        // FIXME: THIS IS NOT SECURE BUT ITS A PLACEHOLDER
        uint256 random = uint256(keccak256(block.timestamp))%numParticipants +1;
        uint8 randomNumber = uint8(random);
        winner = toByte(randomNumber);
    }

    //TODO:
    // Add following methods
    // Int to bit string
    // Generate ith bit
    // Random number generator https://medium.com/@promentol/lottery-smart-contract-can-we-generate-random-numbers-in-solidity-4f586a152b27

    // Make certain functions onlyOwner!
}