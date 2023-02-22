pragma solidity ^0.5;

contract rc20Coin {
    /** State variables **/
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    /** 
        This state variable maps an address to a set of addresse's with a value asociated with them,
        so one address can have multiple address that can use an specific amount of tokens from the first address,
        like a father that let his kids spent an amount of money from his credit card, 
        Father(address) = {son1(address): 100$, son2(address): 200$, son3(address): 150$}
    **/
    mapping(address => mapping(address => uint256)) public allowance;
    /** 
        This is where we need to define all the events that we need to trigger
        and that are require as part of the desgin interface.
    **/

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor() public {
        name = "rc20MyCoin";
        symbol = "RMC";
        decimals = 18;
        /** 
            The total suply of the tokens is in decimals, so we break the tokens into the number of decimals,
            Number of tokens times 10 ^ decimals = totalSupply x 10 ^ 18.
        **/
        totalSupply = 1000000 * (uint256(10) ** decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        /** 
            This first require ensures that the sender have at least the amount of values
            that he wants to send, the sender is the person that invokes the function, so thats
            why we check the balance of the msg.sender.
        **/
        require(balanceOf[msg.sender] >= _value);
        
        /** 
            Then we will update our state variables, because we have to decrement the amount of
            tokens from the sender and increment the amount the token from the receiver.
        **/
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        /** 
            We need to trigger an event with the information of the transaction.
        **/
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /** 
        A function that allow other address to use a specific amount of tokens from the address that is invoking the function
    **/
    function approve(address _spender, uint256 _value) public returns (bool success) {
        /** 
            Here we assign a spender address to the msg.sender address and set this to a specific
            value that can be spent.
        **/
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    /** 
        This function transfer tokens from a address that is not msg.sender but has been previusly approved by the owner of the account
        that the tokens are going to be transfer from.
    **/
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        
        require(balanceOf[_from] >= _value);

        require(allowance[_from][msg.sender] >= _value);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }
}

