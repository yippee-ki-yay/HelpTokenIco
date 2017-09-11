pragma solidity ^0.4.4;

import './lib/SafeMath.sol';

import './ERC20.sol';

contract HelpToken is ERC20 {
    
    using SafeMath for uint256;
    
    string public name = "HelpToken";
    string public token = "HT";
    uint256 public decimals = 18;
    uint256 public NUM_TOKENS = 1000000; // 1 milion of initial NUM_TOKENS
    
    address public owner;
    
    mapping (address => uint256) balances;

    function HelpToken() {
        owner = msg.sender;
        balances[owner] = NUM_TOKENS;
    }
    

    function transfer(address _to, uint _value) returns(bool success) {
        
        //we are not sending it to an empty address
        require(_to != address(0));
        
        //we substract the amount being sent from the senders account
        balances[msg.sender] = balances[msg.sender].sub(_value);
        
        //we add the amount being sent from the sender to our destination address
        balances[_to] = balances[_to].add(_value);
        
        Transfer(msg.sender, _to, _value);
        
        return true;
        
    }
    
    function balanceOf(address owner) constant returns (uint balance) {
        return balances[owner];
    }
    
    function totalSupply() constant returns (uint256) {
        return NUM_TOKENS;
    }
    
}
