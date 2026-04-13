// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";


interface ISpaceCats is IERC721, IERC2981 {
    //function breed() external returns (uint256); 
}