# Basic Token

1) - We have to follow the interface for building Ethereum Tokens, in this case we are going to use eip-20: 
First Link - https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
Second Link - https://eips.ethereum.org/EIPS/eip-20

2) - The document above stablish a set of methods that we have to implement in our smart contract, that's how we create a token.

3) - The RC-20 stablish the fundamental functionality of a token, we may miss a couple of methods required for a fully functional token.

4) - Firs we implement the `name()` function:
    name:
        Returns the name of the token - e.g. "MyToken".

        OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

        `function name() public view returns (string)`
