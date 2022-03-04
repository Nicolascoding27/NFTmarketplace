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
  //From token id to DNA 
  mapping (uint256 => uint256) public tokenDNA;
  constructor(uint256 _maxSupply) ERC721("NICOBABY", "NBB") {}
  string private URL= "https://avataaars.io/";
  function mint() public {
    uint256 current = _idCounter.current(); //Agregando e       l contador de NFTS
    require (current < _maxSupply, "Not enogh Nico baby tokens");
    tokenDNA[current]=deterministicPseudoRandom(current,msg.sender);
     _safeMint(msg.sender, current); //mINTEANDO EL MAXIMO SUPLU
    _idCounter.increment(); //Incrementando el contador de nfts.
  }
//wE
  // lOOF FOR THE METADATA BASED ON THE TOKEN id
  //Al añadir el view nos aseguramos que nuestros usuarios no tiene que pagar gas
  //No hacemos una mutacion de datos es solo una consulta
  //E4l string tiene que pasar  por la memoria para evitar errores
function _baseURI() internal pure override returns (string memory) {
  return "https://avataaars.io/";
}
function _paramsURI(uint256 _dna) internal view returns (string memory){
  string memory params; 
  //funcion p[ara concatenar strings]
  params= string (abi.encodePacked("accsesoriesType=",
   getAccessoriesType(_dna),
   "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                  getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyeBrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna),
                    "&topType",
                    getTopType(_dna)

   ));
  return params;
}
//This function has to be a separate function because 
//it needs to generate a preview of the image 
function imageByDNA (uint256 _dna) public view returns (string memory){
  string memory baseURI= _baseURI();
  string memory params= _paramsURI(_dna);
  return string (abi.encodePacked(baseURI,"", params));
}
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
