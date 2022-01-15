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

    // free zone simple (Simple and Pro)
    mapping(address => string) private _pseudo;
    mapping(address => uint256) private _age;
    mapping(address => string) private _country;
    mapping(address => string) private _wording;
    mapping(address => string) private _item;

    // mapping of simple is register
    mapping(address => bool) private _simple;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;
    // event simple
    event RegisterdSimple(address indexed addr, string pseudo, uint256 age, string country, string wording , string item );
    event RegisterdPSimple(address indexed , string pseudo);
    event ModifiedSimple(address indexed addr, string pseudo, uint256 age, string country, string wording , string item );
    // event pro
    event RegisterdPro(address indexed addr, string pseudo, uint256 age, string country, string wording , string item );
    event RegisterdPro(address indexed , string pseudo);
    event ModifiedPro(address indexed addr, string pseudo, uint256 age, string country, string wording , string item );
}
