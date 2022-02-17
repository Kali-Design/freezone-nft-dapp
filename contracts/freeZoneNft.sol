//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FreeZone is ERC721 {

    // enum later
    // struct
    struct Customer {
        address freeZoneAddress;
        string pseudo;
        uint256 age;
        string country;
        string description;
        string art;
    }
    /// token name
    string private _name;
    // token symbol
    string private _symbol;
    // mapping of people is register
    mapping(uint256 => address) private _register;
    // mapping of the register balance
    mapping(address => uint256) private _balances;
    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){
        _name =  name_;
        _symbol = symbol_;
    }
    // function
    function registerFreeZoneSimple (string memory country, uint256 age) public {
        require (msg.sender != _register, "registerFreeZone : you are register simple");
        msg.sender += _register;
    }

    function registerFreeZonePro (string memory country, uint256 age) public {
        require (msg.sender != _register, "registerFreeZone : you are register pro");
        msg.sender += _register;
    }
    //function view
    function balanceOf (address user) public view returns (uint256){
        require(user == _register, "balanceOf :you are not registred");
        require(owner != address(0), "balanceOf : balance query for the zero address");
    return _balance[_register];
    }
}
