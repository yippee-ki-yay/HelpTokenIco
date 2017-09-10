pragma solidity ^0.4.4;

library SafeMath {
  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

//The ERC20 standard token interface (just basic methods)
contract ERC20 {
     function totalSupply() constant returns (uint totalSupply);
     function balanceOf(address _owner) constant returns (uint balance);
     function transfer(address _to, uint _value) returns (bool success);
     event Transfer(address indexed _from, address indexed _to, uint _value);
}

contract HelpToken is ERC20 {
    
    using SafeMath for uint256;
    
    string public name = "HelpToken";
    string public token = "HT";
    uint256 public decimals = 6;
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