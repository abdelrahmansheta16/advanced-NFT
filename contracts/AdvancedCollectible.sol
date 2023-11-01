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


    bytes32 internal keyHash;
    uint64 subscriptionId;
    VRFCoordinatorV2Interface COORDINATOR;
    
    constructor(address _VRFCoordinator, uint64 _subscriptionId, bytes32 _keyhash) 
    VRFConsumerBaseV2(_VRFCoordinator)
    ERC721("Dogie", "DOG")
    {
        tokenCounter = 0;
        keyHash = _keyhash;
        COORDINATOR = VRFCoordinatorV2Interface(_VRFCoordinator);
        subscriptionId = _subscriptionId;
    }

    function createCollectible(string memory tokenURI) public returns (uint256) {
            uint256 requestId = COORDINATOR.requestRandomWords(keyHash, subscriptionId, 3, 1000000, 1);
            requestIdToSender[requestId] = msg.sender;
            requestIdToTokenURI[requestId] = tokenURI;
            emit RequestedCollectible(requestId);
    }
}
