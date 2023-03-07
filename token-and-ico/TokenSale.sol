pragma solidity ^0.5.0;

interface MyToken {
    function decimals() external view returns(uint8);
    function balanceOf(address _address) external view returns(uint256);
    function transfer(address _to, uint256 _value) public returns(bool success);
}

contract TokenSale {
    address owner;
    uint256 price;
    MyToken myTokenContract;
    uint256 tokenSold;

    event Sold(address buyer, uint256 amount);

    constructor(uint256 _price, address _addressContract) public {
        owner = msg.sender;
        price = _price;
        myTokenContract = MyToken(_addressContract);
    }

    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        if(a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }

    function buy(uint256 _numTokens) public payable {
        require(msg.value == mul(price, _numTokens));
        uint256 scaledAmount = mul(_numTokens, uint256(10) ** myTokenContract.decimals());
        require(myTokenContract.balanceOf(address(this)) >= scaledAmount);
        tokenSold += _numTokens;
        require(myTokenContract.transfer(msg.sender, scaledAmount));
        emit Sold(msg.sender, _numTokens);
    }

    function endSold() public {
        require(msg.sender == owner);
        require(myTokenContract.transfer(owner, myTokenContract.balanceOf(address(this))));
        msg.sender.transfer(address(this).balance);
    }
}
