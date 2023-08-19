// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    string public name;
    uint256 public totalSupply;
    mapping(address => bool) public allowlist;

    mapping(address => uint256) public balanceOf;

    constructor(string memory _name, uint256 _totalSupply) {
        name = _name;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
    }

    modifier onlyAllowlisted() {
        require(allowlist[msg.sender], "Address not allowlisted");
        _;
    }

    function addToAllowlist(address _address) public {
        allowlist[_address] = true;
    }

    function removeFromAllowlist(address _address) public {
        allowlist[_address] = false;
    }

    function transfer(address _to, uint256 _amount) public onlyAllowlisted {
        require(_amount <= balanceOf[msg.sender], "Insufficient balance");
        require(_to != address(0), "Invalid address");

        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
    }
}