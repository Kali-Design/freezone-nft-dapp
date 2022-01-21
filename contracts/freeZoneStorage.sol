//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract freeZone is ERC721, ERC721Enumerable, ERC721URIStorage, AccessControl {

    // using address from openzeppelin
    using Address for address payable;
    using Counters for Counters. Counter;
    using Strings for uint256;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // struct
    struct  Customer {
        string pseudo;
        uint256 age;
        string country;
        string description;
        string image;
    }

    // mapping of simple is register
    mapping(address => bool) private _simple;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;
    
    // working progress
}
