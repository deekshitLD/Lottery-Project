pragma solidity >=0.5.3;

contract Lottery{
    address public owner;
    address payable[] public players;

    constructor() public{
        owner = msg.sender;
    }

    modifier OwnerOnly{
        if(msg.sender ==owner){
            _;
        }
    }
    function deposit() public payable{
        require(msg.value >=1 ether);
        players.push(msg.sender);
    } 
    function GenerateRandomNum() public view returns(uint){
        return uint(keccak256(abi.encodePacked(now,block.difficulty,players.length)));
    }

    function pickWinner()  OwnerOnly public{
        uint randomNumber = GenerateRandomNum();
        uint index = randomNumber % players.length;

        address payable winner;

        winner = players[index];

        //transferring balance to winner
        winner.transfer(address(this).balance);

        //Reset the Players array
        players = new address payable [](0);

    }
}

