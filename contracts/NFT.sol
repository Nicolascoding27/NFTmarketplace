//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";
import "./NicoPunksDNA.sol";


// contract NFT {
contract NFT is ERC721, ERC721Enumerable, NicoPunksDNA {
  using Counters for Counters.Counter;
  Counters.Counter private _idCounter;
  uint256 public _maxSupply;

  constructor(uint256 _maxSupply) ERC721("NICOBABY", "NBB") {}

  function mint() public {
    uint256 current = _idCounter.current(); //Agregando e       l contador de NFTS
    _safeMint(msg.sender, current); //mINTEANDO EL MAXIMO SUPLU
    _idCounter.increment(); //Incrementando el contador de nfts.
  }

  // lOOF FOR THE METADATA BASED ON THE TOKEN id
  //Al añadir el view nos aseguramos que nuestros usuarios no tiene que pagar gas
  //No hacemos una mutacion de datos es solo una consulta
  //E4l string tiene que pasar  por la memoria para evitar errores
  function tokenURI(uint256 tokenId)
    public
    view
    override
    returns (string memory)
  {
    require(_exists(tokenId), "ERC721 Metadata: Querying for unexisting token"); //Exits verifies that the token exists or not
    //First we encode the string together and put it in Bytes using ABI
    // string memory jsonUri = string(abi.encodePacked("NBB", "TO the moon")); //Url for data format funcion
/**
Construyendo el JSON package, first arg name to the ABI encoding
 */

 string memory jsonURI=Base64.encode(
 abi.encodePacked(
    '{"name": "Nico Baby #"}',
    //nEEDS TO BE QA STRING AND IT IS A NUMBER
    //https://docs.openzeppelin.com/contracts/4.x/api/utils#Strings
    tokenId,
    '","description" : "This is the Nico Baby token the best token you will ever see"', "image:"""
    // URGENT: ADD NFT URL IMAGE
    '"}'
)
 );
    //ADD WWW Specification
    return string (abi.encodePacked("data: application/json; base64,", jsonURI));
  }

  // Necessary to support enumn
  
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }
}
