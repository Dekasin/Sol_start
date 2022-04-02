/ SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract BuyMe{
    address  payable contractCreator;
    address public owner;
    uint public contractPrice;
    string public messagForAll;


    modifier onlyOwner(){
        require(msg.sender==owner, "not owner");
        _;
    }

    constructor(){
        contractCreator = payable (msg.sender);
        owner = msg.sender;
        contractPrice = 10**10 wei;
    }

    receive()external payable {
        
        if (msg.value > contractPrice){
           
            address payable _to = payable (owner);
            address _thisContract = address(this);
            contractCreator.transfer(_thisContract.balance / 1000);
            _to.transfer(_thisContract.balance / 1000 * 999);

            owner = msg.sender;

        } else { }
      
    }

    fallback() external payable {
        console.log("do nothing");
    }

    function setMessagForAll(string memory _messageForAll) public onlyOwner{
        messagForAll = _messageForAll;
    }

    function changePrice (uint _newPrice, uint decimal) public onlyOwner{

        contractPrice = _newPrice * 10**decimal;
    }

    function changeOwner( address _newOwner) public onlyOwner{

        owner = _newOwner;
    }

    function killContract()public onlyOwner{
    
        selfdestruct(contractCreator);
    }

}