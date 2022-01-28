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
        string art;
    }

    // mapping of simple is register
    mapping(address => bool) private _simple;

    // mapping of pro is register
    mapping(address => bool) private _pro;

    // mapping of the register balance
    mapping(address => uint256) private _balances;
    
    // constructor
    constructor() ERC721("freeZoneNFTsimple", "freeZoneNFTpro", "FNP") {
        _setupRole(MINTER_ROLE, msg.sender);
    }

    // function
    function registerFreeZoneSimple(string memory pseudo , uint256 age, string memory country, string memory description, string memory art) public onlyRole(MINTER_ROLE) returns (uint256){
        require(_simple[msg.sender] == false, "freeZone: you are already registered as simple");
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        _fnpIds.increment();
        uint256 currentId = _fnpIds.current();
        _mint(msg.sender, currentId);
        _setTokenURI(currentId, currentId.toString());
        _zonesimple[currentId] = ZoneSimple(pseudo, age, country, description, art);
        _simple[msg.sender] = true;
        return currentId;

        emit RegisterSimple(msg.sender, pseudo);
    }

    function registerFreeZonePro(string memory pseudo , uint256 age, string memory country, string memory description, string memory art) public onlyRole(MINTER_ROLE) returns (uint256){
        require(_pro[msg.sender] == false, "freeZone: you are already registered as pro");
        require(_simple[msg.sender] == false, "freeZone: you are already registered as simple");
        _fnpIds.increment();
        uint256 currentId = _fnpIds.current();
        _mint(msg.sender, currentId);
        _setTokenURI(currentId, currentId.toString());
        _zonepro[currentId] = ZonePro(pseudo, age, country, description, art);
        _pro[msg.sender] = true;
        return currentId;

        emit RegisterPro(msg.sender, pseudo);
    }
    
    function getFreeZoneById(uint256 id) public view returns (ZoneSimple memory) {
        return _zoneSimple[id];
    }

    function getFreeZoneById(uint256 id) public view returns (ZonePro memory) {
        return _zonePro[id];
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721URIStorage, ERC721) returns (string memory) {
        return super.tokenURI(tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )  internal virtual override(ERC721Enumerable, ERC721) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721URIStorage, ERC721) {
        super._burn(tokenId);
    }
}
