pragma solidity ^0.4.4;

import './HelpToken.sol';

contract Crowdsale {
    
    using SafeMath for uint256;
    
    HelpToken public token;
    
    uint256 public tokenPrice;
    uint256 public costPerEther = 1000; //you get a thousand tokens for 1 ether
    uint256 public deadline;

    address public ownerAddress;
    
    event TokenBought(address indexed buyer, uint256 indexed amountInWei);
    
    function Crowdsale(address _ownerAddress, uint256 numDaysSaleLasts) {
        
        require(_ownerAddress != 0x0);

        //the first param it the user who started the ICO and the second is the ICO contract address
        token = new HelpToken(msg.sender, this);

        ownerAddress = _ownerAddress;
        tokenPrice = costPerEther * 1 ether;
        deadline = now + numDaysSaleLasts * 1 days;
    }
    
    
    function buyTokens(address buyer) payable {
        require(buyer != 0x0);
        require(msg.value != 0);
        require(deadline >= now);
        
        uint256 amountInWei = msg.value;
        
        uint256 tokenAmount = amountInWei.div(tokenPrice);
        
        TokenBought(buyer, amountInWei);
        
        token.transfer(buyer, tokenAmount);
        
        ownerAddress.transfer(amountInWei);
        
    }
    
    function () payable {
        buyTokens(msg.sender);
    }
    
    
}

