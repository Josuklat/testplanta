// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract PlantsCards is ERC1155, ERC1155Burnable, Ownable {
   
   uint256 public constant PLANTA1 = 0;
   uint256 public constant PLANTA2 = 1;

   constructor()
        ERC1155 ( "https://ipfs.io/ipfs/QmTBjJB3e1ZbWLbm3pPKPeD6jxwGoHkv34kq7HGd9fiaUn/{id}.json" ) {

    _mint(msg.sender, PLANTA1, 100, "");
    _mint(msg.sender, PLANTA2, 20, "");

   }

   function uri(
        uint256 _tokenid
   ) public pure override returns (string memory) {
    return
        string(
            abi.encodePacked(
                "https://ipfs.io/ipfs/QmTBjJB3e1ZbWLbm3pPKPeD6jxwGoHkv34kq7HGd9fiaUn",
                Strings.toString(_tokenid),
                ".json"
            )
        );
   }
   function airdrop(uint256 tokenId, address[] calldata recipients) external onlyOwner {
    for (uint i = 0; i < recipients.length; i++) 
    {
        _safeTransferFrom(msg.sender, recipients[i], tokenId, 1, "");

        if (
            balanceOf(owner(), PLANTA1) == 90 &&
            balanceOf(owner(), PLANTA2) == 1
        ) {
            _safeTransferFrom(msg.sender, recipients[i], PLANTA2, 1, "");
        }
    }
   }
    
    function _beforeTOkenTransfer(
            address operator,
            address from,
            address to,
            uint256[] memory ids,
            uint256[] memory amounts, 
            bytes memory data
        

    ) internal override {
        super._beforeTOkenTransfer(operator, from, to, ids, amounts, data);
        require(
            //msg.sender
            mg.sender == owner() || to == address(0),
            "No se puede, solo quemar el NFT"

        );
    }
    

}
