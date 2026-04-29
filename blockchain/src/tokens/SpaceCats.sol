// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//import {ISpaceCats} from "./interfaces/ISpaceCats.sol";

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";

/*
                                                                                                              
      ___           ___         ___           ___           ___                    ___           ___                         ___     
     /\__\         /\  \       /\  \         /\__\         /\__\                  /\__\         /\  \                       /\__\    
    /:/ _/_       /::\  \     /::\  \       /:/  /        /:/ _/_                /:/  /        /::\  \         ___         /:/ _/_   
   /:/ /\  \     /:/\:\__\   /:/\:\  \     /:/  /        /:/ /\__\              /:/  /        /:/\:\  \       /\__\       /:/ /\  \  
  /:/ /::\  \   /:/ /:/  /  /:/ /::\  \   /:/  /  ___   /:/ /:/ _/_            /:/  /  ___   /:/ /::\  \     /:/  /      /:/ /::\  \ 
 /:/_/:/\:\__\ /:/_/:/  /  /:/_/:/\:\__\ /:/__/  /\__\ /:/_/:/ /\__\          /:/__/  /\__\ /:/_/:/\:\__\   /:/__/      /:/_/:/\:\__\
 \:\/:/ /:/  / \:\/:/  /   \:\/:/  \/__/ \:\  \ /:/  / \:\/:/ /:/  /          \:\  \ /:/  / \:\/:/  \/__/  /::\  \      \:\/:/ /:/  /
  \::/ /:/  /   \::/__/     \::/__/       \:\  /:/  /   \::/_/:/  /            \:\  /:/  /   \::/__/      /:/\:\  \      \::/ /:/  / 
   \/_/:/  /     \:\  \      \:\  \        \:\/:/  /     \:\/:/  /              \:\/:/  /     \:\  \      \/__\:\  \      \/_/:/  /  
     /:/  /       \:\__\      \:\__\        \::/  /       \::/  /                \::/  /       \:\__\          \:\__\       /:/  /   
     \/__/         \/__/       \/__/         \/__/         \/__/                  \/__/         \/__/           \/__/       \/__/                                                                                           
                                        
                                 
*/

contract SpaceCats is AccessControl, ERC2981, ERC721, ERC721Burnable, ERC721URIStorage  {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant GAME_ENGINE = keccak256("GAME_ENGINE");
    uint256 private _nextTokenId;

    mapping(uint256 => bool) public isLocked;


    constructor(address defaultAdmin) 
    ERC721("SpaceCats", "SPC") 
    {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _setDefaultRoyalty(msg.sender, 350);
    }

    function lockCat(uint256 id) external onlyRole(GAME_ENGINE) {
        isLocked[id] = true;
    }
    
    function unlockCat(uint256 id) external onlyRole(GAME_ENGINE) {
        isLocked[id] = false;
    }

    function _update(address to, uint256 tokenId, address auth) internal virtual override returns (address) {
        require(!isLocked[tokenId], "The cat is currently under mission or in a spaceship");
        return super._update(to, tokenId, auth);
    }

    function safeMint(address to, string memory uri)
        public
        onlyRole(MINTER_ROLE)
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage, AccessControl, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}