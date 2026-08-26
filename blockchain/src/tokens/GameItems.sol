// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";


contract GameItems is ERC1155, ERC1155URIStorage, ERC1155Supply, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant GAME_ENGINE_ROLE = keccak256("GAME_ENGINE_ROLE");
    
    uint256 public constant FOOD = 1;
    uint256 public constant DRINK = 2;
    uint256 public constant TOY = 3;
    uint256 public constant SHIELD = 4;

    constructor(address defaultAdmin, address minter, address gameEngine) 
    ERC1155("example.com/{id}.json")
    {
        _grantRole(MINTER_ROLE, minter);
        _grantRole(GAME_ENGINE_ROLE, gameEngine);
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
    }

    function mint(address to, uint256 id, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, id, amount, "");
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory values) public onlyRole(MINTER_ROLE) {
        _mintBatch(to, ids, values, "");
    }

    function burnForGame(address from, uint256 id, uint256 amount) public onlyRole(GAME_ENGINE_ROLE) {
        _burn(from, id, amount);
    }

    function updateItemURI(uint256 id, string memory newURI) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _setURI(id, newURI);
    }

    //required overrides

    function uri(uint256 tokenId)
        public
        view
        override(ERC1155, ERC1155URIStorage)
        returns (string memory)
    {
        return super.uri(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override(ERC1155, ERC1155Supply) {
        super._update(from, to, ids, values);
    }
}