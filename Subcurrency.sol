pragma solidity >=0.5.0 <0.7.0;

//simple smart contract of mint the coin from the sender, and make the transaction inbetween the sendr and receiver
contract coin{
    address public minter; //public variable hold the minter address
    mapping (address => uint) public balances; //hash map to match the address with amount

    event Sent(address from, address to, uint amount);

    //constructer code for iniating the contract
    constructor() public{
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public{
        require(msg.sender == minter); // make sure the sender the minter
        require(amount < 1e60); // mak sure the contract amount is less than 1e160
        balances[receiver] += amount; // after all requirements meet, mint the amount to the sender's balance
    }

    function send(address receiver, uint amount) public{
        require(amount <= balances[msg.sender], "Insufficient Balance."); // make sure the amount sent by sender is not exceeding the balance
        balances[msg.sender] -= amount; // after all requiremets meet, wire out the amount from sender first
        balances[receiver] += amount; // after the amount wire out from the sender, wire into the balance of the receiver
        emit Sent(msg.sender, receiver, amount); // fullfill the contract by emitting the result
    }

}