pragma solidity ^0.4.4;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract HelpToken is StandardToken {
    string public name = "HelpToken";
    string public token = "HT";
    uint public decimals = 6;
    uint public NUM_TOKENS = 1000000; // 1 milion of initial NUM_TOKENS

    function HelpToken() {
        totalSupply = NUM_TOKENS;
        balances[msg.sender] = NUM_TOKENS;
    }
}