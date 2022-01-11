//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FreeZone is ERC721 {

    // enum ?

    // struct
    struct Customer {
        address freeZoneAddress;
        string pseudo;
        uint256 age;
        string country;
        string wording;
        string item;
    }

    // Token name
    string private _name;

    // Token symbol
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
}
