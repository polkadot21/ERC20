// Implementation of an ERC-20 Token

pragma solidity >=0.7.0 <0.9.0;


interface iERC20 {

    //returns the total supply of tokens available
    function totalSupply() external returns (uint256);

    function balanceOf(address _owner) external returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    function approve(address _spender, uint256 _value) external returns (bool success);

    function allowance(address _owner, address _spender) external returns (uint256 remaining);

}


contract iLoveMittweida is iERC20 {

    string public name;
    string public symbol;
    uint256 public override totalSupply;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    address payable owner;

    constructor(uint256 _initialSupply, string memory _name, string memory _symbol) {
        totalSupply = _initialSupply;
        owner = payable(msg.sender);
        balances[msg.sender] = _initialSupply;

        name = _name;
        symbol = _symbol;
    }


    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);



    function balanceOf(address _owner) public override view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require (_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = allowed[msg.sender][_spender] + _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public override view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from] - _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
