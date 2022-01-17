//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract freeZone is ERC721 {

    // using address from openzeppelin
    using Address for address payable;

        // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // free zone (Simple and Pro)
    mapping(address => string) private _pseudo;
    mapping(address => uint256) private _age;
    mapping(address => string) private _country;
    mapping(address => string) private _description;
    mapping(address => string) private _image;

    // mapping of simple is register
    mapping(address => bool) private _simple;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;
    
    // event simple
    event RegisterSimple(address indexed addr, string pseudo, uint256 age, string country, string description, string image);
    event RegisterSimple(address indexed , string pseudo);
    event ModifiedSimple(address indexed addr, string pseudo, uint256 age, string country, string description, string image);
    // event pro
    event RegisterPro(address indexed addr, string pseudo, uint256 age, string country, string description, string image);
    event RegisterPro(address indexed , string pseudo);
    event ModifiedPro(address indexed addr, string pseudo, uint256 age, string country, string description, string image);

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

     // function
    function registerSimple(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory image_) public {
        require(_simple[msg.sender] == false, "freeZone you are already registered as simple");
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = image_;
        _simple[msg.sender] = true;

        emit RegisterSimple(msg.sender, _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _image[msg.sender]);
    }

    function registerPro(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory image_) public {
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        require(_simple[msg.sender] == false, "freeZone: you are already registered as simple");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = image_;
        _pro[msg.sender] = true;

        emit RegisterPro(msg.sender, _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _image[msg.sender]);
    }
    
    function modifyProfile(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory image_) public {
        require(_simple[msg.sender] == true, "freeZone: only user can use this function");
        require(_pro[msg.sender] == false, "freeZone: only user can use this function");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = image_;

        emit ModifyProfile(msg.sender , _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _image[msg.sender]);
    }
}
