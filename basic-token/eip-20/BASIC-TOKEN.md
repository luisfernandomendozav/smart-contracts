# Basic Token

1) - We have to follow the interface for building Ethereum Tokens, in this case we are going to use eip-20: 
First Link - https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
Second Link - https://eips.ethereum.org/EIPS/eip-20

2) - The document above stablish a set of methods that we have to implement in our smart contract, that's how we create a token.

3) - The RC-20 stablish the fundamental functionality of a token, we may miss a couple of methods required for a fully functional token.

[NOTE] REMEMBER THAT WHEN WE DECLARE A STATE VARIABLE AS PUBLIC SOLIDITY AUTOMATICALLY GENERATES THE GETTER FUNCTIONS, THATS WHY WE DONT SEE IT ON THE CONTRACT WE JUST SEE THE STATE VARIABLES.

4) - Firs we implement the `name()` function:
    name:
        Returns the name of the token - e.g. "MyToken".

        OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

        `function name() public view returns (string)`

5) - Then we implement the `symbol()` function:
    symbol:
        Returns the symbol of the token. E.g. “HIX”.

        OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

        `function symbol() public view returns (string)`

5) - In a smart contract we don't have float numbers, we need to find a way to  operate with decimals without using float numbers.
    decimals:
        Returns the number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to get its user representation.

        OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

        `function decimals() public view returns (uint8)`

6) - Returns the total token supply of the contract.
    totalSupply:
        Returns the total token supply.

        `function totalSupply() public view returns (uint256)`

7) - We need a set of keys associated to values, this refers to the number of tokens that each address have.
    balanceOf:
        Returns the account balance of another account with address _owner.

        `function balanceOf(address _owner) public view returns (uint256 balance)`
[NOTE] At this point we only have defined values that only need getters, i.e. that doesn't modify the state variables, we will begging by implementing the functions that set this variables.

8) - We will implement a function that allows us to tranfers tokens from one address to another.
    transfer:
        Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.

        Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.

        `function transfer(address _to, uint256 _value) public returns (bool success)`
    
    1) - Transfer Event.
        Transfer:
            MUST trigger when tokens are transferred, including zero value transfers.

            A token contract which creates new tokens SHOULD trigger a Transfer event with the _from address set to 0x0 when tokens are created.

            `event Transfer(address indexed _from, address indexed _to, uint256 _value)`

9) - Then we will implement the approve function, this function allows another address to manage a specific quantity of tokens from the address that is invoking the function:
    approve:
    Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value.

    NOTE: To prevent attack vectors like the one described here and discussed here, clients SHOULD make sure to create user interfaces in such a way that they set the allowance first to 0 before setting it to another value for the same spender. THOUGH The contract itself shouldn’t enforce it, to allow backwards compatibility with contracts deployed before

    `function approve(address _spender, uint256 _value) public returns (bool success)`
        1) - Approval Event.
            Approval
            MUST trigger on any successful call to approve(address _spender, uint256 _value).

            `event Approval(address indexed _owner, address indexed _spender, uint256 _value)`

10) - Since we have implemented the approve function, then we need to implement a function that allows that approve addres to send tokens from the approver, this is the next function.
    transferFrom:
    Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.

    The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies. The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism.

    Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.

    `function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)`