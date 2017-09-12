pragma solidity ^0.4.4;

//The ERC20 standard token interface (just basic methods)
contract ERC20 {
     function totalSupply() constant returns (uint totalSupply);
     function balanceOf(address _owner) constant returns (uint balance);
     function transfer(address _to, uint _value) returns (bool success);
     function allowance(address owner, address spender) constant returns (uint256);
     function transferFrom(address from, address to, uint256 value) returns (bool);
     function approve(address spender, uint256 value) returns (bool);
     
     event Approval(address indexed owner, address indexed spender, uint256 value);
     event Transfer(address indexed _from, address indexed _to, uint _value);
}