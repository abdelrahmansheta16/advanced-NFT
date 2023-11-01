pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract AdvancedCollectible is VRFConsumerBaseV2, ERC721URIStorage {
    uint256 public tokenCounter;
    enum Breed{PUG, SHIBA_INU, ST_BERNARD}
    // add other things
    mapping(uint256 => address) public requestIdToSender;
    mapping(uint256 => string) public requestIdToTokenURI;
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(uint256 => uint256) public requestIdToTokenId;
    event RequestedCollectible(uint256 indexed requestId); 
    // New event from the video!
    event ReturnedCollectible(uint256 indexed newItemId, Breed breed);
}