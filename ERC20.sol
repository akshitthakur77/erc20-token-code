//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ERC20Token {

    string public constant name = "akshay";
    string public constant symbol = "w";
    uint8 public constant decimals = 18;  


    event Approval(address indexed tokenOwner, address indexed spender, uint token);

//event and emit uses together to store or view information on inside blockchain
    event Transfer(address indexed from, address indexed to, uint tokens);


    
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    uint256 totalSupply_;


//for intialization we use constructor 

   constructor() {  

	totalSupply_ = 10000000000000000000000000000000000000000000000000000000;
 //one hundred thousand crore token
	balances[msg.sender] = totalSupply_; 

    }  

    function totalSupply() public view returns (uint256) {
	return totalSupply_;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender]=balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
       emit  Approval(msg.sender, delegate, numTokens);
        return true;
    }
    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }


    function transferFrom(address owner, address friend, uint numTokens) public returns (bool) {
        
        
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);
    
        balances[owner] = balances[owner]-numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens; 
        balances[friend] =  balances[friend]+numTokens;


        emit  Transfer(owner, friend, numTokens);

        return true;
    }
}

