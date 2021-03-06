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
    mapping(address => string) private _art;

    // mapping of simple is register
    mapping(address => bool) private _simple;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;
    
    // event simple
    event RegisterSimple(address indexed addr, string pseudo, uint256 age, string country, string description, string art);
    event RegisterSimple(address indexed , string pseudo);
    event ModifiedSimple(address indexed addr, string pseudo, uint256 age, string country, string description, string art);
    // event pro
    event RegisterPro(address indexed addr, string pseudo, uint256 age, string country, string description, string art);
    event RegisterPro(address indexed , string pseudo);
    event ModifiedPro(address indexed addr, string pseudo, uint256 age, string country, string description, string art);

    // constructor
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // functions
    function registerSimple(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory art_) public {
        require(_simple[msg.sender] == false, "freeZone : you are already registered as simple");
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = art_;
        _simple[msg.sender] = true;

        emit RegisterSimple(msg.sender, _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _image[msg.sender]);
    }

    function registerPro(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory art_) public {
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        require(_simple[msg.sender] == false, "freeZone: you are already registered as simple");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = art_;
        _pro[msg.sender] = true;

        emit RegisterPro(msg.sender, _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _art[msg.sender]);
    }
    
    function modifyProfile(string memory pseudo_ , uint256 age_ , string memory country_, string memory description_, string memory art_) public {
        require(_simple[msg.sender] == true, "freeZone: only user can use this function");
        require(_pro[msg.sender] == false, "freeZone: only user can use this function");
        _pseudo[msg.sender] = pseudo_;
        _age[msg.sender] = age_;
        _country[msg.sender] = country_;
        _description[msg.sender] = description_;
        _image[msg.sender] = art_;

        emit ModifyProfile(msg.sender , _pseudo[msg.sender], _age[msg.sender], _country[msg.sender], _description[msg.sender], _art[msg.sender]);
    }

    function balancesOf(address user_) public view returns (uint256) {
        require(_simple[user_] == true, "freeZone: you are not registred");
        require(user_ != address(0), "freeZone: balance query for the zero address");
        return _balances[user_];
    }
    
    // function view for each states of customer
    function getPseudo (address user_) public view returns (string memory) {
        return _pseudo[user_];
    }
    function getAge (address user_) public view returns (uint256) {
        return _age[user_];
    }
    function getCountry (address user_) public view returns (string memory) {
        return _country[user_];
    }

    function getDescription (address user_) public view returns (string memory) {
        return _description[user_];
    }

    function getArt (address user_) public view returns (string memory) {
        return _art[user_];
    }
    // optionnal to check status
    function getStatus (address user_) public view returns (uint256) {
        uint256 status = 0;
        if(_simple[user_] == true) return 1;
        if(_pro[user_] == true) return 2;
        return status ;
    }
}  
