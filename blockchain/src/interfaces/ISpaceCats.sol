// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";



interface ISpaceCats is IAccessControl, IERC2981, IERC721 {
    //function breed() external returns (uint256); 
}