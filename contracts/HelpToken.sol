pragma solidity ^0.4.4;

import './lib/SafeMath.sol';

import './ERC20.sol';

contract HelpToken is ERC20 {
    
    using SafeMath for uint256;
    
    string public name = "HelpToken";
    string public token = "HLT";
    uint256 public decimals = 18;
    uint256 public NUM_TOKENS = 1000000; // 1 milion of initial NUM_TOKENS
    uint256 public NUM_TOKENS_FOR_ICO = 200000;

    address public owner;
    address public ico;
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function HelpToken(address _owner, address _ico) {
        owner = _owner;
        ico = _ico;
        balances[owner] = NUM_TOKENS - NUM_TOKENS_FOR_ICO;
        balances[ico] = NUM_TOKENS_FOR_ICO;
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

    function drainIco() onlyOwner {
        balances[owner] = balances[owner].add(balances[ico]);
        balances[ico] = 0;
    }
    
    function balanceOf(address owner) constant returns (uint balance) {
        return balances[owner];
    }
    
    function totalSupply() constant returns (uint256) {
        return NUM_TOKENS;
    }
    
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool) {
        require(_to != address(0));
    
        var _allowance = allowed[_from][msg.sender];
    
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = _allowance.sub(_value);
        Transfer(_from, _to, _value);
        return true;
   }

  function approve(address _spender, uint256 _value) returns (bool) {


    require((_value == 0) || (allowed[msg.sender][_spender] == 0));

    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }
    
}

