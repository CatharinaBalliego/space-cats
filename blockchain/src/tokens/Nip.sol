// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract KNip is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant GAME_ENGINE_ROLE = keccak256("GAME_ENGINE_ROLE");

    constructor() ERC20("KNIP", "KNIP") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burnForGame(address from, uint256 amount) public onlyRole(GAME_ENGINE_ROLE) {
        _burn(from, amount);
    }

}